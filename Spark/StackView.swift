//
//  StackView.swift
//  Spark
//
//  Created by Jason Yang on 2/27/17.
//  Copyright © 2017 Jason Yang. All rights reserved.
//

import UIKit

protocol StackViewDelegate {
    func swipeViewDidFinishSwiping()
}

protocol StackViewDataSource {
    func numberOfSwipeViewsInStack() -> Int
    func swipeViewForIndex(index: Int) -> SwipeView
}

class StackView: UIView {
    
    var delegate: StackViewDelegate?
    var dataSource: StackViewDataSource?
    var swipeViewArray: [SwipeView] = []
    
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
        for index in 0...numberOfSwipeViews! {
            let newSwipeView = SwipeView()
            let scale = 1.0 - (CGFloat(index) * CGFloat(Constants.kStackViewScaleDifference))
            let yOffset = CGFloat(index) * CGFloat(Constants.kStackViewYOffset)
            setupSwipeViewConstraints(swipeView: newSwipeView, scale: scale, yOffset: yOffset)
        }
        swipeViewArray[0].enableSwipe()
    }
    
    private func setupSwipeViewConstraints(swipeView: SwipeView, scale: CGFloat, yOffset: CGFloat) {
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.topAnchor.constraint(equalTo: self.topAnchor, constant: yOffset).isActive = true
        swipeView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        swipeView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: scale).isActive = true
        swipeView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: scale).isActive = true
    }
    
    
    

}
