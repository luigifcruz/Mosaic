//
//  RenderImageColor.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/28/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import Foundation
import UIKit

public struct UIImageColors {
    public var backgroundColor: UIColor!
}

class PCCountedColor {
    let color: UIColor
    let count: Int
    
    init(color: UIColor, count: Int) {
        self.color = color
        self.count = count
    }
}

extension UIColor {
    
    public var isDarkColor: Bool {
        let RGB = CGColorGetComponents(self.CGColor)
        return (0.2126 * RGB[0] + 0.7152 * RGB[1] + 0.0722 * RGB[2]) < 0.5
    }
    
    public var isBlackOrWhite: Bool {
        let RGB = CGColorGetComponents(self.CGColor)
        return (RGB[0] > 0.91 && RGB[1] > 0.91 && RGB[2] > 0.91) || (RGB[0] < 0.09 && RGB[1] < 0.09 && RGB[2] < 0.09)
    }
}

extension UIImage {
    
    public func resize(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        self.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    public func getColors() -> UIImageColors {
        let ratio = self.size.width/self.size.height
        let r_width: CGFloat = 250
        return self.getColors(CGSizeMake(r_width, r_width/ratio))
    }
    
    public func getColors(scaleDownSize: CGSize) -> UIImageColors {
        var result = UIImageColors()
        
        let cgImage = self.resize(scaleDownSize).CGImage
        let width = CGImageGetWidth(cgImage)
        let height = CGImageGetHeight(cgImage)
        
        let bytesPerPixel: Int = 4
        let bytesPerRow: Int = width * bytesPerPixel
        let bitsPerComponent: Int = 8
        let randomColorsThreshold = Int(CGFloat(height)*0.01)
        let sortedColorComparator: NSComparator = { (main, other) -> NSComparisonResult in
            let m = main as! PCCountedColor, o = other as! PCCountedColor
            if m.count < o.count {
                return NSComparisonResult.OrderedDescending
            } else if m.count == o.count {
                return NSComparisonResult.OrderedSame
            } else {
                return NSComparisonResult.OrderedAscending
            }
        }
        let blackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let raw = malloc(bytesPerRow * height)
        let bitmapInfo = CGImageAlphaInfo.PremultipliedFirst.rawValue
        let ctx = CGBitmapContextCreate(raw, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo)
        CGContextDrawImage(ctx, CGRectMake(0, 0, CGFloat(width), CGFloat(height)), cgImage)
        let data = UnsafePointer<UInt8>(CGBitmapContextGetData(ctx))
        
        let leftEdgeColors = NSCountedSet(capacity: height)
        let imageColors = NSCountedSet(capacity: width * height)
        
        for x in 0..<width {
            for y in 0..<height {
                let pixel = ((width * y) + x) * bytesPerPixel
                let color = UIColor(
                    red: CGFloat(data[pixel+1])/255,
                    green: CGFloat(data[pixel+2])/255,
                    blue: CGFloat(data[pixel+3])/255,
                    alpha: 1
                )
                
                // A lot of albums have white or black edges from crops, so ignore the first few pixels
                if 5 <= x && x <= 10 {
                    leftEdgeColors.addObject(color)
                }
                
                imageColors.addObject(color)
            }
        }
        
        // Get background color
        let enumerator = leftEdgeColors.objectEnumerator()
        let sortedColors = NSMutableArray(capacity: leftEdgeColors.count)
        while let kolor = enumerator.nextObject() as? UIColor {
            let colorCount = leftEdgeColors.countForObject(kolor)
            if randomColorsThreshold < colorCount  {
                sortedColors.addObject(PCCountedColor(color: kolor, count: colorCount))
            }
        }
        sortedColors.sortUsingComparator(sortedColorComparator)
        
        var proposedEdgeColor: PCCountedColor
        if 0 < sortedColors.count {
            proposedEdgeColor = sortedColors.objectAtIndex(0) as! PCCountedColor
        } else {
            proposedEdgeColor = PCCountedColor(color: blackColor, count: 1)
        }
        
        if proposedEdgeColor.color.isBlackOrWhite && 0 < sortedColors.count {
            for i in 1..<sortedColors.count {
                let nextProposedEdgeColor = sortedColors.objectAtIndex(i) as! PCCountedColor
                if (CGFloat(nextProposedEdgeColor.count)/CGFloat(proposedEdgeColor.count)) > 0.3 {
                    if !nextProposedEdgeColor.color.isBlackOrWhite {
                        proposedEdgeColor = nextProposedEdgeColor
                        break
                    }
                } else {
                    break
                }
            }
        }
        result.backgroundColor = proposedEdgeColor.color
        
        free(raw)
        
        return result
    }
    
}