//
//  SwipeView.swift
//  Spark
//
//  Created by Jason Yang on 2/25/17.
//  Copyright © 2017 Jason Yang. All rights reserved.
//

import Foundation
import UIKit

class SwipeView: UIView {
    
    private let cardView: CardView = CardView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    convenience init() {
        self.init(frame:CGRect.zero)
        initialize()
    }
    
    private func initialize() {
        self.backgroundColor = Constants.kSwipeViewBackgroundColor
        self.layer.shadowColor = Constants.kSwipeViewShadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: CGFloat(Constants.kSwipeViewShadowOffset), height: CGFloat(Constants.kSwipeViewShadowOffset))
        self.layer.shadowOpacity = Float(Constants.kSwipeViewShadowOpacity)
        self.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        setCardViewConstraints()
    }
    
    private func setCardViewConstraints() {
        cardView.topAnchor.constraint(equalTo: self.topAnchor, constant:CGFloat(Constants.kSwipeViewPadding)).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(Constants.kSwipeViewPadding * -1.0)).isActive = true
        cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(Constants.kSwipeViewPadding)).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(Constants.kSwipeViewPadding * -1.0)).isActive = true
    }
    
    func swipeViewSwiped(gestureRecognizer: UIPanGestureRecognizer) {
        let distance = gestureRecognizer.translation(in: self)
        print(distance)
    }

}
