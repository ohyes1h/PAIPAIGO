//
//  httpPost.swift
//  Hackathon
//
//  Created by Phyllis on 2015/2/1.
//  Copyright (c) 2015年 ohyes1h. All rights reserved.
//

import Foundation
class httpPost {
    //class func post(params : Dictionary<String, String>, url : String) {
    class func post(params : String, url : String) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        
        var body:NSMutableData = NSMutableData()
        
        //let contentType:NSString="multipart/form-data;"
        //request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        let boundary:String="--FormBoundary\r\n"
        
        let b:NSData=(boundary as NSString).dataUsingEncoding(NSUTF8StringEncoding) as NSData!
        
        body.appendData(b)
        let str:String="Content-Disposition: form-data; name=\"UPLOAD\"\r\n"
        let data1:NSData=(str as NSString).dataUsingEncoding(NSUTF8StringEncoding) as NSData!
        
        body.appendData(data1)
        let data2:NSData=("\(params)\r\n" as NSString).dataUsingEncoding(NSUTF8StringEncoding) as NSData!
        body.appendData(data2)
        body.appendData(b)
        request.HTTPBody=body
        //request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        //request.addValue(params, forHTTPHeaderField: "UPLOAD")
        //request.setValue(params, forKey: "UPLOAD")
                //request.setValue(params, forKey: "UPLOAD" as String)
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }
}