//
//  ImageViewController.swift
//  Perooze
//
//  Created by Caroline Shi on 11/18/15.
//  Copyright © 2015 NapperApps. All rights reserved.
//

import UIKit
import MBProgressHUD
import TesseractOCR

class ImageViewController: UIViewController, G8TesseractDelegate {
    
    //MARK: Properties
    var image: UIImage?
    var text: String?
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: Actions
    @IBAction func scan(sender: UIBarButtonItem) {
        
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate

        loadingNotification.labelText = "Processing the Image"
        loadingNotification.detailsLabelText = "This may take a minute"

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)){
                
                let process = ProcessAndOCR()
                self.text = process.recognizeImage(self.image!)

                dispatch_async(dispatch_get_main_queue()) {
                
                    self.performSegueWithIdentifier("Try Text", sender: self.text)

                    loadingNotification.hide(true)
                }
            }
        }


    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Try Text" {
            let a = segue.destinationViewController as! TextViewController
            a.text = sender as? String
            /*let twoString = sender as! (String, String)
            a.text = twoString.0
            a.searchWord = twoString.1*/
           
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
