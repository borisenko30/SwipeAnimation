//
//  ViewController.swift
//  SwipeAnimation
//
//  Created by Oleksandr Borysenko on 3/1/18.
//  Copyright © 2018 Oleksandr Borysenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var swipedView: UIView!
    
    private var isViewHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dragRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.onDrag(sender:)))
        self.view.addGestureRecognizer(dragRecognizer)
    }

    // MARK: - private methods
    
    @objc private func onDrag(sender: UIPanGestureRecognizer) {
        let view = self.view
        let screenWidth = UIScreen.main.bounds.width
        
        var dragDistance = sender.translation(in: view).x
        
        /* view should be hidden if we drag it more than half screen width
         * if it's already hidden we should show it
         */
        let shouldHideView = (abs(dragDistance) > screenWidth / 2) != self.isViewHidden
        
        dragDistance = dragDistance >= 0 ? dragDistance : screenWidth + dragDistance
        
        switch sender.state {
        case .changed:
            self.swipedView.frame.origin.x = dragDistance
        case .ended:
            let finalPosition = shouldHideView ? screenWidth : 0
            self.isViewHidden = finalPosition == screenWidth
            UIView.animate(withDuration: 0.8, animations: {
                self.swipedView.frame.origin.x = finalPosition
            })
        default: break
        }
    }
}

