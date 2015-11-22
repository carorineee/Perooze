//
//  TextViewController.swift
//  Perooze2
//
//  Created by Caroline Shi on 11/18/15.
//  Copyright © 2015 NapperApps. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var outputText: UITextView!
    var text: String?
    var searchWord: String?
    
    func findSubstring(substring: String, inString string: String) -> [NSRange] {
        let string = NSString(string: string)
        
        var ranges = [NSRange]()
        
        var searchRange = NSMakeRange(0, string.length)
        var foundRange: NSRange?
        
        while searchRange.location < string.length {
            searchRange.length = string.length - searchRange.location
            foundRange = string.rangeOfString(substring, options: [], range: searchRange)
            if foundRange?.location == NSNotFound {
                break
            } else {
                ranges.append(foundRange!)
                searchRange.location = foundRange!.location + foundRange!.length
            }
        }
        
        return ranges
    }
    
    
    func highlightWord(text: String, word: String){
        
        let ranges = findSubstring(searchWord!, inString: text)
        let attributed = NSMutableAttributedString(string: text)

        for i in 0..<ranges.count {
            attributed.addAttribute(NSBackgroundColorAttributeName, value: UIColor.yellowColor(), range: ranges[i])}
        
        outputText.text = String(attributed)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        highlightWord(text!, word: searchWord!)

        

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
