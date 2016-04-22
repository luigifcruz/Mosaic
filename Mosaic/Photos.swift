//
//  Photos.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/22/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import Foundation
import Photos

class Photos {
    class func getPermission(completion: (result: Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization({ (status) -> Void in
            if status == .Authorized {
                completion(result: true)
            } else {
                completion(result: false)
            }
        })
    }
    
    class func getNumber(day: NSDate, type: PHAssetMediaType, completion: (result: Bool) -> Void) {
        let requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = true
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithMediaType(type, options: fetchOptions) {
        
            if fetchResult.count > 0 {
                for i in 0...fetchResult.count - 1 {
                    let media = fetchResult.objectAtIndex(i) as! PHAsset
                    
                    if isSameDays(media.creationDate!, day) {
                        print(media.mediaSubtypes)
                    }
                }
            }
        }
    }
}
