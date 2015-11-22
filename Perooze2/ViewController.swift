//
//  ViewController.swift
//  Perooze2
//
//  Created by Caroline Shi on 11/12/15.
//  Copyright © 2015 NapperApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var choosePhotoButton: UIButton!
    
    
    //MARK: Image selection
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        dismissViewControllerAnimated(true) {
            self.performSegueWithIdentifier("ShowImage", sender: selectedImage)
        }
    }
    
    //MARK: Choose photo actions
    @IBAction func takePhoto(sender: UIButton) {
        let imagePickCon = UIImagePickerController()
        imagePickCon.sourceType = .Camera
        imagePickCon.delegate = self
        presentViewController(imagePickCon, animated: true, completion: nil)
        
    }
    
    @IBAction func choosePhoto(sender: UIButton) {
        let imagePickCon = UIImagePickerController()
        imagePickCon.sourceType = .PhotoLibrary
        imagePickCon.delegate = self
        presentViewController(imagePickCon, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //If user cancelled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowImage" {
            let a = segue.destinationViewController as! ImageViewController
            a.image = sender as? UIImage
        }
    }

}

