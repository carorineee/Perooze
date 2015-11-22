//
//  ImageViewController.swift
//  Perooze2
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
    var searchWord: String?
    var text: String?
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: Actions
    @IBAction func askForWord(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Search", message: "Enter a search word below.", preferredStyle: .Alert)
        
        //Search word
        alertController.addTextFieldWithConfigurationHandler { (searchWordTextField) -> Void in
            searchWordTextField.placeholder = "Enter search word here"
        }
        
        
        
        //Search and cancel
        let searchAction = UIAlertAction(title: "Search", style: .Default) { action in
            
            let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.Indeterminate
            loadingNotification.labelText = "Loading"
            
            let searchWord = (alertController.textFields![0] as UITextField).text
            let process = ProcessAndOCR()
            self.text = process.recognizeImage(self.image!)
            
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            self.performSegueWithIdentifier("Try Text", sender: self.text)

        }

        
        alertController.addAction(searchAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        //UIImagePNGRepresentation(image!)
        let processOCR = ProcessAndOCR()
        image = processOCR.aspectRatio(self.image!, maxDimension: 640)

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
            /*let twoString = sender as! (String, String)
            a.text = twoString.0
            a.searchWord = twoString.1*/
            a.text = sender as? String
            a.searchWord = sender as? String
            
           
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
