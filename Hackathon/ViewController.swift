//
//  ViewController.swift
//  Hackathon
//
//  Created by Phyllis on 2015/1/31.
//  Copyright (c) 2015年 ohyes1h. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController,UIImagePickerControllerDelegate,UIPickerViewDelegate,UINavigationControllerDelegate,UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var picBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var travelLine: UIWebView!
    @IBOutlet weak var bottomBar: UIView!
    //@IBOutlet var picCollectionView: UICollectionView!
    //let reusableCollectionCell="ScenaryCell"
    //@IBOutlet weak var picView: UIImageView!=UIImageView()
    //var base64Array:[NSString]=[]
    //var picArray:[UIImage]=[]
    var base64Data:NSString=""
    var picData:UIImage=UIImage()
    var delegate=UIApplication.sharedApplication().delegate as AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        travelLine.scalesPageToFit=true
        var urlAddress="http://demo.innstory.com/"
        var url:NSURL=NSURL(string: urlAddress)!
        var requestObj=NSURLRequest(URL: url)
        travelLine.loadRequest(requestObj)
        //picBtn.addTarget(self, action: "showPopover:", forControlEvents: UIControlEvents.TouchUpInside)
        cameraBtn.addTarget(self, action: "performCamera:", forControlEvents: UIControlEvents.TouchUpInside)
//        cameraBtn.layer.backgroundColor=UIColor.whiteColor().CGColor
//        cameraBtn.layer.borderWidth=1
//        cameraBtn.layer.borderColor=UIColor.grayColor().CGColor
//        cameraBtn.layer.cornerRadius=2.5
        bottomBar.alpha=0.8
    }
/*
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var flow:UICollectionViewFlowLayout=UICollectionViewFlowLayout()
        flow.itemSize=CGSizeMake(65,65)
        picCollectionView=UICollectionView(frame: collectionView.frame, collectionViewLayout: flow)
        picCollectionView.setCollectionViewLayout(flow, animated: false)
        
        let cell:ScenaryImgCell=collectionView.dequeueReusableCellWithReuseIdentifier(reusableCollectionCell, forIndexPath: indexPath) as ScenaryImgCell
        
        var atIndex:Int=indexPath.row
        var tmpPic=picArray[atIndex]
        var thumbnail = Utility.scaleImageWith(tmpPic,newSize: CGSize(width: 65,height: 65))


        cell.ScenaryImg.image=thumbnail
        
        return cell
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func performCamera(sender:UIButton){
        println("performCamera")
     
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            var imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.mediaTypes = NSArray(object: kUTTypeImage)
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        println("i've got an image");
        picker.dismissViewControllerAnimated(true, completion: nil)
        //var thumbnail = Utility.scaleImageWith(image,newSize: CGSize(width: 40,height: 40))
        println("image width:\(image.size.width)")
        println("image height:\(image.size.height)")
        var scaledImage:UIImage
        
        if(image.size.width >= image.size.height){
            //landscape
            scaledImage = Utility.scaleImageWith(image,newSize: Utility.getLandscapePicSize())
        }else{
            //portrait
            scaledImage = Utility.scaleImageWith(image,newSize: Utility.getPortraitPicSize())
        }
        //picArray.append(scaledImage)
        //base64Array.append(Utility.UIImageToBase64(scaledImage))
        picData=scaledImage
        base64Data=Utility.UIImageToBase64(scaledImage)
        delegate.u_picture64=base64Data
        delegate.u_filename="file1.jpg"
        delegate.u_city="Taipei"
        
        
        
        dispatch_async(dispatch_get_main_queue()) {
            // update some UI
            //self.picView.image=scaledImage
            self.picBtn.setBackgroundImage(scaledImage, forState: UIControlState.Normal)
            
        }
        self.performSegueWithIdentifier("infoSegue", sender: self)
    }
    
    @IBAction func test(sender: UIButton) {
        //picCollectionView.reloadData()
//        picCollectionView.reloadInputViews()
       // picCollectionView.reloadSections(NSIndexSet(index: 0))
//        dispatch_async(dispatch_get_main_queue()) {
//            // update some UI
//            self.picCollectionView.reloadItemsAtIndexPaths(self.picCollectionView.indexPathsForVisibleItems())
//        }
    }
    func showPopover(sender:UIButton){
        /*
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SchedulePopoverStoryBoard" bundle:nil];
        ScheduleOnCalendarViewController *viewControllerForPopover =
        [sb instantiateViewControllerWithIdentifier:@"schedulePopup"];
        viewControllerForPopover.date = dateStr;
        viewControllerForPopover.customerId = [self.event stringCustomerID];//[NSString stringWithFormat:@"%@",[self.event numCustomerID]];
        //UIPopoverController *popover;
        self.popover = [[UIPopoverController alloc]
        initWithContentViewController:viewControllerForPopover];
        
        [self.popover presentPopoverFromRect:CGRectMake(0,45, 1028 , 768)//anchor.frame
        inView:self//anchor.superview
        permittedArrowDirections:0 animated:YES];
        
*/
/*
        //PopupStoryBoard
        var sb:UIStoryboard=UIStoryboard(name: "UploadInfoStoryboard", bundle: nil)
        //UploadInfoViewController
        var popVC:UploadInfoViewController=sb.instantiateViewControllerWithIdentifier("uploadPopover") as UploadInfoViewController
        popVC.preferredContentSize=CGSizeMake(300, 300)
        
       
        presentViewController(popVC, animated: true, completion: nil)
*/
    }
//    func prepareForPopoverPresentation(popoverPresentationController: UIPopoverPresentationController) {
//        popoverPresentationController.containerView=CGSizeMake(300, 300)
//    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC:PopoverViewController=segue.destinationViewController as PopoverViewController
        destVC.preferredContentSize=CGSizeMake(300, 400)
    }
}
class ScenaryImgCell:UICollectionViewCell{
    
    @IBOutlet var ScenaryImg: UIImageView!=UIImageView()
}

