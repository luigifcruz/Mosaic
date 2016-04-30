//
//  Photos.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/22/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import Foundation
import Photos

struct ImageLocation {
    var image: UIImage? = nil
    var coordinate: CLLocationCoordinate2D? = nil
}

class Photos {
    class func getPermission() {
        PHPhotoLibrary.requestAuthorization({
            (status) -> Void in
            
            switch status {
            case .Authorized:
                TrackerMaster.updateCardStatus("Photos", date: NSDate(), status: true)
                break;
            case .Denied, .Restricted:
                TrackerMaster.updateCardStatus("Photos", date: NSDate(), status: false)
                break;
            case .NotDetermined:
                TrackerMaster.updateCardStatus("Photos", date: NSDate(), status: false)
                break;
            }
        })
    }
    
    class func get(day: NSDate, type: PHAssetMediaType, completion: (result: PHFetchResult) -> Void) {
        let requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = true
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithMediaType(type, options: fetchOptions) {
            
            if fetchResult.count > 0 {
                completion(result: fetchResult)
            }
        }
    }
    
    class func getLivePhotosCount(day: NSDate, completion: (result: Int) -> Void) {
        get(day, type: .Image) {
            (result) in
            
            var mediaCount = 0
            
            for i in 0...result.count - 1 {
                let media = result.objectAtIndex(i) as! PHAsset
                
                if isSameDays(media.creationDate!, day) {
                    if media.mediaSubtypes.rawValue == 8 {
                        mediaCount += 1
                    }
                }
            }
            
            completion(result: mediaCount)
        }
    }
    
    class func getMediaLocation(day: NSDate, media: PHAssetMediaType, completion: (result: [ImageLocation]) -> Void) {
        get(day, type: media) {
            (result) in
            
            var mediaCount: [ImageLocation] = []
            
            for i in 0...result.count - 1 {
                let media = result.objectAtIndex(i) as! PHAsset
                
                if isSameDays(media.creationDate!, day) {
                    if let location = media.location?.coordinate {
                        var payload = ImageLocation()
                        payload.coordinate = location
                        payload.image = getAssetThumbnail(media)
                        
                        mediaCount.append(payload)
                    }
                }
            }
            
            completion(result: mediaCount)
        }
    }
    
    class func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.defaultManager()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.synchronous = true
        manager.requestImageForAsset(asset, targetSize: CGSize(width: 45.0, height: 45.0), contentMode: .AspectFill, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    class func getMediaCount(day: NSDate, media: PHAssetMediaType, completion: (result: Int) -> Void) {
        get(day, type: media) {
            (result) in
            
            var mediaCount = 0
            
            for i in 0...result.count - 1 {
                let media = result.objectAtIndex(i) as! PHAsset
                
                if isSameDays(media.creationDate!, day) {
                    mediaCount += 1
                }
            }
            
            completion(result: mediaCount)
        }
    }
    
}
