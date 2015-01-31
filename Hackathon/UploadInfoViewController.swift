//
//  UploadInfoViewController.swift
//  Hackathon
//
//  Created by Phyllis on 2015/1/31.
//  Copyright (c) 2015年 ohyes1h. All rights reserved.
//

import UIKit

class UploadInfoViewController: UIViewController {
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.preferredContentSize.height=UIScreen.mainScreen().bounds.height/2//768*0.67//UIScreen.mainScreen().bounds.width//600
        //self.preferredContentSize.width=UIScreen.mainScreen().bounds.width//1024*0.67//UIScreen.mainScreen().bounds.height//600
        //self.popoverContentSize = CGSizeMake(300, 300);
        self.preferredContentSize = CGSizeMake(100.0, 100);
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
