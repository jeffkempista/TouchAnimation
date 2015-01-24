//
//  ViewController.swift
//  TouchAnimation
//
//  Created by Jeff Kempista on 1/24/15.
//  Copyright (c) 2015 Jeff Kempista. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gradientView: CircleGradient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "screenPan:")
        self.view.addGestureRecognizer(panGestureRecognizer)
    }

    func screenPan(gesture: UIPanGestureRecognizer!) {
        let point = gesture.locationInView(self.view)
        
        if (gesture.state == .Began || gesture.state == .Changed) {
            self.gradientView.center = point
        } else if (gesture.state == .Ended) {
            self.gradientView.fadeOut()
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if let touch = touches.anyObject() as? UITouch {
            let newCenter = touch.locationInView(self.view)
            self.gradientView.center = newCenter
            self.gradientView.fadeIn()
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.gradientView.fadeOut()
    }

}

