//
//  TextViewController.swift
//  Perooze
//
//  Created by Caroline Shi on 11/18/15.
//  Copyright © 2015 NapperApps. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var outputText: UITextView!
    var text: String?
    var searchWord: String = ""
    
    
    @IBAction func searchWord(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Search", message: "Enter a search word below.", preferredStyle: .Alert)
        
        //Search word
        alertController.addTextFieldWithConfigurationHandler { (searchWordTextField) -> Void in
            searchWordTextField.placeholder = "Enter search word here"
        }
        
        
        let searchAction = UIAlertAction(title: "Search", style: .Default) { action in

            self.searchWord = (alertController.textFields![0] as UITextField).text!
            self.highlightWord(self.text!, word: self.searchWord)
        
        }
        
        alertController.addAction(searchAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    static func findSubstring(substring: String, inString string: String) -> [NSRange] {
        let string = NSString(string: string)
        
        var ranges = [NSRange]()
        
        var searchRange = NSMakeRange(0, string.length)
        var foundRange: NSRange?
        
        while searchRange.location < string.length {
            searchRange.length = string.length - searchRange.location
            foundRange = string.rangeOfString(substring, options: [], range: searchRange)
            if foundRange?.location == NSNotFound {
                break
            }
            else {
                ranges.append(foundRange!)
                searchRange.location = foundRange!.location + foundRange!.length
            }
        }
        
        return ranges
    }
    
    
    func highlightWord(text: String, word: String) {
        
        let ranges = TextViewController.findSubstring(searchWord, inString: text)
        let attributedText = NSMutableAttributedString(string: text)

        for range in ranges {
            attributedText.addAttribute(NSBackgroundColorAttributeName, value: UIColor.yellowColor(), range: range)
        }
        

        outputText.attributedText = attributedText
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        outputText.text = text

        // Do any additional setup after loading the view.
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
