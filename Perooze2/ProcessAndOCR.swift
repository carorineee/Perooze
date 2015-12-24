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
import GPUImage

class ProcessAndOCR: NSObject, G8TesseractDelegate {
    
    //MARK: Properties
    
    var image: UIImage?
    var text: String?
    let tesseract:G8Tesseract = G8Tesseract(language:"eng")
    
    //MARK: Scaling the image (Try 1)
    /*func aspectRatio(image: UIImage, maxDimension: CGFloat) -> UIImage {
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
    }*/

    
    //MARK: Tesseract stuff

    
    func recognizeImage(image: UIImage) -> String {
        
        // Shrink the image
        let zzz = 3;
        let newSize = CGSizeMake((image.size.width / CGFloat(zzz)), (image.size.height / CGFloat(zzz)))
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //Threshold filter
        let filter = GPUImageAdaptiveThresholdFilter()
        let filteredImage = filter.imageByFilteringImage(resizedImage)

        tesseract.delegate = self
        tesseract.charWhitelist = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        tesseract.engineMode = .TesseractCubeCombined
        tesseract.pageSegmentationMode = .Auto
        //tesseract.maximumRecognitionTime = 20.0
   
        tesseract.image = filteredImage.g8_grayScale()
        //tesseract.sourceResolution = 330
        tesseract.recognize()
        //NSLog("%@", tesseract.recognizedText)
        
        text = tesseract.recognizedText
        return text!
    }




}