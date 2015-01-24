//
//  CircleGradient.swift
//  TouchAnimation
//
//  Created by Jeff Kempista on 1/24/15.
//  Copyright (c) 2015 Jeff Kempista. All rights reserved.
//

import UIKit
import QuartzCore

class CircleGradient: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.contents = self.generateRadial().CGImage
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.contents = self.generateRadial().CGImage
    }
    
    func generateRadial() -> UIImage {
        
        // Define the gradient
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        let numberOfLocations: size_t = 5
        
        let locations: [CGFloat] = [0.0, 0.4, 0.5, 0.6, 1.0]
        let components: [CGFloat] = [  1.0, 0.0, 0.0, 0.2,
                            1.0, 0.0, 0.0, 1,
                            1.0, 0.0, 0.0, 0.8,
                            1.0, 0.0, 0.0, 0.4,
                            1.0, 0.0, 0.0, 0.0]
        
        var gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, numberOfLocations)
        
        // Define gradient positions
        
        // We want these exactly at the center of the view
        let centerX = CGRectGetWidth(self.frame) / 2
        let centerY = CGRectGetHeight(self.frame) / 2
        var startPoint = CGPoint(x: centerX, y: centerY)
        var endPoint = CGPoint(x: centerX, y: centerY)
        
        // Generate the image
        // Begin an image context
        UIGraphicsBeginImageContext(self.frame.size)
        let imageContext = UIGraphicsGetCurrentContext()
        // Use CG to draw the radial gradient into the image context
        CGContextDrawRadialGradient(imageContext, gradient, startPoint, 0, endPoint, CGRectGetWidth(self.frame) / 2, 0)
        // Get the image from the context
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func fadeIn() {
        
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0
        fadeIn.toValue = 1
        
        fadeIn.duration = 0.3
        
        self.layer.addAnimation(fadeIn, forKey: "fade")
    }
    
    func fadeOut() {
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1
        fadeOut.toValue = 0
        
        fadeOut.duration = 0.3
        
        fadeOut.fillMode = kCAFillModeForwards
        fadeOut.removedOnCompletion = false
        
        self.layer.addAnimation(fadeOut, forKey: "fade")
    }
    
}
