//
//  Utility.swift
//  Hackathon
//
//  Created by Phyllis on 2015/1/31.
//  Copyright (c) 2015年 ohyes1h. All rights reserved.
//

import Foundation
import UIKit
class Utility {
    class func scaleImageWith(image:UIImage, newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    class func getLandscapePicSize()->CGSize {
        if(UIScreen.mainScreen().scale==2.0){
            //retina screen
            return CGSize(width: 400,height: 300)
        }
        return CGSize(width: 800,height: 600)
    }
    class func getPortraitPicSize()->CGSize {
        if(UIScreen.mainScreen().scale==2.0){
            //retina screen
            return CGSize(width: 300,height: 400)
        }
        return CGSize(width: 600,height: 800)
    }
    class func UIImageToBase64(image:UIImage)->String{
        var imageData=UIImagePNGRepresentation(image)
        let base64String:String=imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
        return base64String
    }
}
