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
    var delegate=UIApplication.sharedApplication().delegate as AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        uploadBtn.addTarget(self, action: "performUpload:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    func performUpload(sender:UIButton){
        let date:NSDate=NSDate()
        delegate.u_date=Utility.dateToString(date)
        delegate.u_picTitle=titleText.text
        delegate.u_picDescr=descrText.text
        delegate.u_user="User1"
        delegate.u_site="Site"
        
        var dict:NSDictionary=Utility.composeJson()
        var param:NSString="\(dict)"
        println(param)
        httpPost.post(param, url: Utility.serviceUrl)
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
