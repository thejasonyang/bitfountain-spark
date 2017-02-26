//
//  CardsViewController.swift
//  Spark
//
//  Created by Jason Yang on 2/26/17.
//  Copyright © 2017 Jason Yang. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var currentCard: SwipeView = SwipeView()
    var nextCard: SwipeView = SwipeView()
    private var currentCardOrigin: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(nextCard)
        self.view.addSubview(currentCard)
        
        setupSwipeViewConstraints(swipeView: nextCard, offset: CGFloat(Constants.kCardOffsetMargin))
        setupSwipeViewConstraints(swipeView: currentCard, offset: 0.0)
        
        currentCardOrigin = currentCard.center
        
        currentCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipeViewSwiped(gestureRecognizer:))))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Setup
    
    private func setupSwipeViewConstraints(swipeView: SwipeView, offset: CGFloat) {
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: CGFloat(Constants.kCardStackTopOffset) + offset).isActive = true
        swipeView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: offset).isActive = true
        swipeView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: CGFloat(Constants.kCardStackWidthMultiplier)).isActive = true
        swipeView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: CGFloat(Constants.kCardStackHeightMultiplier)).isActive = true
    }
    
    //MARK: Gestures
    
    func swipeViewSwiped(gestureRecognizer: UIPanGestureRecognizer) {
        let distance = gestureRecognizer.translation(in: self.view)
        currentCard.center = CGPoint(x: currentCardOrigin!.x + distance.x, y: currentCardOrigin!.y + distance.y)
    }
    
}
