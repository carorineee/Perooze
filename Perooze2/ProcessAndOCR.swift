//
//  ProcessAndOCR.swift
//  Perooze2
//
//  Created by Caroline Shi on 11/18/15.
//  Copyright © 2015 NapperApps. All rights reserved.
//

import Foundation
import UIKit
import TesseractOCR

class ProcessAndOCR: NSObject, G8TesseractDelegate {
    
    //MARK: Properties
    
    var image: UIImage?
    var text: String?
    

    //MARK: Scaling the image
    func aspectRatio(image: UIImage, maxDimension: CGFloat) -> UIImage {
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor: CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        
        UIGraphicsBeginImageContext(scaledSize)
        image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        return scaledImage
    }

    
    //MARK: OpenCV PreProcessing
    
    /*func scaleImage(image: UIImage, x: Int, y: Int) -> UIImage {
        for y in 0..<y {
            for x in 0..<x {
                var srcX0 = CGFloat(x) * ((image.size.width-1)/CGFloat(x))
                var srcY0 = CGFloat(y) * ((image.size.height-1)/CGFloat(y))
                var srcX1 = CGFloat(x+1) * ((image.size.width-1)/CGFloat(x))
                var srcY1 = CGFloat(y+1) * ((image.size.height-1)/CGFloat(y))
                var val=0
                var count=0
                
                
                for i in Int(srcY0)..<Int(srcY1) {
                    for j in Int(srcX0)..<Int(srcX1) {
                        val += Interpolate2([Int(y)][Int(x)], [Int(y)][Int(x+1)],
                            [Int(y+1)][Int(x+1)], [Int(y+1)][Int(x+1)],
                            x, y);
                        count++;
                    }
                }
                [Int(y)][Int(x)] = val/count;
            }
        }
        return image
    }*/
    
    
    //MARK: Tesseract stuff
    
    func recognizeImage(image: UIImage) -> String {
        let tesseract:G8Tesseract = G8Tesseract(language:"eng");
        //tesseract.setVariableValue("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
          // forKey: "tessedit_char_whitelist")
        tesseract.delegate = self
        tesseract.charWhitelist = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        tesseract.engineMode = .TesseractCubeCombined
        tesseract.pageSegmentationMode = .Auto
        tesseract.maximumRecognitionTime = 20.0
        
        //Process
        
        tesseract.analyseLayout()
        NSLog("%@", tesseract.deskewAngle)
        
        
        
        tesseract.image = image.g8_grayScale()
        tesseract.sourceResolution = 330
        tesseract.recognize()
        NSLog("%@", tesseract.recognizedText)
        
        text = tesseract.recognizedText
        return text!
    }
    
    

    
}