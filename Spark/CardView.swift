//
//  CardView.swift
//  Spark
//
//  Created by Jason Yang on 2/25/17.
//  Copyright © 2017 Jason Yang. All rights reserved.
//

import Foundation
import UIKit

class CardView: UIView {
    
    private let imageView: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = Constants.kCardViewImageBackgroundColor
        self.addSubview(imageView)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        self.layer.cornerRadius = CGFloat(Constants.kCardViewCornerRadius)
        self.layer.masksToBounds = true
        setConstraints()
    }
    
    private func setConstraints() {
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(Constants.kCardViewNameLabelHeight * -1.0)).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(Constants.kCardViewNameLabelXMargin)).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(Constants.kCardViewNameLabelXMargin * -1.0)).isActive = true
        
    }
        
}
