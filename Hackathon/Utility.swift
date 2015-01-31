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
    class var serviceUrl:NSString{
        return "http://demo.innstory.com/mservice.php"
    }
    
    
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
    class func composeJson()->NSDictionary{
        let delegate=UIApplication.sharedApplication().delegate as AppDelegate
        var payload:NSDictionary=["filename":delegate.u_filename,
                                "date":delegate.u_date,
                                "city":delegate.u_city,
                                "site":delegate.u_site,
                                "title":delegate.u_picTitle,
                                "desciption":delegate.u_picDescr,
                                "picture":delegate.u_picture64,
                                "lon":delegate.u_lng,
                                "lat":delegate.u_lat] as NSDictionary
        var json:NSDictionary=["user":delegate.u_user,
                            "payload":[payload] as NSArray] as NSDictionary
        return json
    }
    class func dateToString(date:NSDate) -> NSString {
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var string:NSString = dateFormatter.stringFromDate(date)
        
        return string
    }
}
