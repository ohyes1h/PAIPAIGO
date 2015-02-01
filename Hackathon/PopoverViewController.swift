//
//  PopoverViewController.swift
//  Hackathon
//
//  Created by Phyllis on 2015/2/1.
//  Copyright (c) 2015年 ohyes1h. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    @IBOutlet weak var uploadBtn:UIButton!=UIButton()
    @IBOutlet weak var titleText: UITextField!

    @IBOutlet weak var descrText: UITextView!
    
    @IBOutlet weak var timeLabel:UILabel!=UILabel()
    var delegate=UIApplication.sharedApplication().delegate as AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        uploadBtn.addTarget(self, action: "performUpload:", forControlEvents: UIControlEvents.TouchUpInside)
        println("width:\(self.presentingViewController?.preferredContentSize.width)")
        
        timeLabel.text=Utility.dateToString(NSDate())
        delegate.u_date=timeLabel.text!
        
    }
    func performUpload(sender:UIButton){
        let date:NSDate=NSDate()
        delegate.u_date=Utility.dateToString(date)
        delegate.u_picTitle=titleText.text
        delegate.u_picDescr=descrText.text
        delegate.u_user="Alex"
        delegate.u_site="Site"
        delegate.u_city="台北市"
        
        //var dict:NSDictionary=Utility.composeJson()
        //var param:NSString="\(dict)"
        var param:NSString=Utility.composeJson()
        println(param)
        //httpPost.post(param, url: Utility.serviceUrl)
        /*
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"foo": @"bar"};
        [manager POST:@"http://example.com/resources.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        }];
        */
        
        var manager:AFHTTPRequestOperationManager=AFHTTPRequestOperationManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html")//"text/html")//multipart/form-data
        let parameters:NSDictionary=["UPLOAD":param] as NSDictionary
        
        manager.POST(Utility.serviceUrl, parameters: parameters, success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
            println("JSON: "+responseObject.description)
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            
            
            NSNotificationCenter.defaultCenter().postNotificationName("doRefresh", object:nil, userInfo:nil)
            }, failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
