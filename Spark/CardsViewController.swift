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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(nextCard)
        self.view.addSubview(currentCard)
        
        setupSwipeViewConstraints(swipeView: nextCard, offset: 0.0)
        setupSwipeViewConstraints(swipeView: currentCard, offset: CGFloat(Constants.kCardOffsetMargin))
        
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
    
}
