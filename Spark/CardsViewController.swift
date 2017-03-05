//
//  CardsViewController.swift
//  Spark
//
//  Created by Jason Yang on 2/26/17.
//  Copyright © 2017 Jason Yang. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, StackViewDataSource {

    var stackView: StackView = StackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.dataSource = self
        
        self.view.addSubview(stackView)
        setupStackView()
        
    }
    
    override func viewDidLayoutSubviews() {
        stackView.initializeStack()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Setup
    
    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: CGFloat(Constants.kCardStackTopOffset)).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: CGFloat(Constants.kCardStackWidthMultiplier)).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: CGFloat(Constants.kCardStackHeightMultiplier)).isActive = true
    }
    
    //MARK: StackViewDataSource
    
    func numberOfSwipeViewsInStack() -> Int {
        return 3
    }
    
    func swipeViewForIndex(index: Int) -> SwipeView {
        return SwipeView()
    }
    
}
