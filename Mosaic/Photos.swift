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
    
    class func getNumber(day: NSDate, type: PHAssetMediaType, livePhoto: Bool, completion: (result: Int) -> Void) {
        let requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = true
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithMediaType(type, options: fetchOptions) {
        
            if fetchResult.count > 0 {
                var mediaCount = 0
                
                for i in 0...fetchResult.count - 1 {
                    let media = fetchResult.objectAtIndex(i) as! PHAsset
                    
                    if isSameDays(media.creationDate!, day) {
                        if media.mediaSubtypes.rawValue == 8 && livePhoto {
                            mediaCount += 1
                        } else if !livePhoto {
                            mediaCount += 1
                        }
                    }
                }
                
                completion(result: mediaCount)
            }
        }
    }
}
