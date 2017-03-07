//
//  StackView.swift
//  Spark
//
//  Created by Jason Yang on 2/27/17.
//  Copyright © 2017 Jason Yang. All rights reserved.
//

import UIKit

protocol StackViewDataSource {
    func numberOfSwipeViewsInStack() -> Int
    func swipeViewForIndex(index: Int) -> SwipeView
}

class StackView: UIView, SwipeViewDelegate {
    
    var dataSource: StackViewDataSource?
    var swipeViewStack: [SwipeView] = []
    
    //MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame:CGRect.zero)
    }
    
    func initializeStack() {
        let numberOfSwipeViews = dataSource?.numberOfSwipeViewsInStack()
        
        for index in 0...numberOfSwipeViews! - 1 {
            swipeViewStack.append(SwipeView())
            
            if index == 0 {
                self.addSubview(swipeViewStack[index])
                swipeViewStack[index].enableSwipe()
            } else {
                self.insertSubview(swipeViewStack[index], belowSubview: swipeViewStack[index - 1])
                swipeViewStack[index].alpha = 1.0 - CGFloat(index) * CGFloat(Constants.kStackViewAlphaDifference)
            }
            
            let scale = 1.0 - CGFloat(index) * CGFloat(Constants.kStackViewScaleDifference)
            let yOffset = (self.frame.height * CGFloat(index) * CGFloat(Constants.kStackViewScaleDifference))/2 * CGFloat(Constants.kStackViewYOffset)
            setupSwipeViewConstraints(swipeView: swipeViewStack[index], scale: scale, yOffset: yOffset)
            
        }
        
        
    }
    
    private func setupSwipeViewConstraints(swipeView: SwipeView, scale: CGFloat, yOffset: CGFloat) {
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.topAnchor.constraint(equalTo: self.topAnchor, constant: yOffset).isActive = true
        swipeView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        swipeView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: scale).isActive = true
        swipeView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: scale).isActive = true
    }
    
    func actionForSwipeCompletionPercentage(swipeCompletionPercentage: CGFloat) {
        if swipeCompletionPercentage > CGFloat(Constants.kSwipeViewCompletionTrigger) {
            
        }
    }
    
    func swipeViewDidFinishSwiping(swipeRight: Bool) {
        
    }
    

}
