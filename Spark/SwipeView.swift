//
//  SwipeView.swift
//  Spark
//
//  Created by Jason Yang on 2/25/17.
//  Copyright © 2017 Jason Yang. All rights reserved.
//

import Foundation
import UIKit

protocol SwipeViewDelegate {
    func actionForSwipeCompletionPercentage(swipeCompletionPercentage: CGFloat)
    func swipeViewDidFinishSwiping(swipeRight: Bool)
}

class SwipeView: UIView {
    
    var delegate: SwipeViewDelegate?
    private let cardView: CardView = CardView()
    private var startingCenter: CGPoint?
    
    //MARK: Init
    
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
    
    //MARK: Gestures
    
    func enableSwipe() {
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipeViewSwiped(gestureRecognizer:))))
    }
    
    func swipeViewSwiped(gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            startingCenter = self.center
            self.layer.shouldRasterize = true
            break
        case .changed:
            let distance = gestureRecognizer.translation(in: self.superview!.superview!)
            let direction: CGFloat = distance.x <= 0.0 ? -1.0 : 1.0
            let strength = abs(distance.x) / self.superview!.superview!.frame.width
            let rotationAngle = direction * min(strength * (CGFloat(Constants.kSwipeViewRotationAngle) * CGFloat(M_PI_2) / 180), CGFloat(Constants.kSwipeViewRotationAngle) * CGFloat(M_PI_2) / 180)
            let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
            self.transform = rotationTransform
            self.center = CGPoint(x: startingCenter!.x + distance.x, y: startingCenter!.y + distance.y)
            let completionPercentage = distance.x / (self.superview!.superview!.frame.width / 2)
            delegate?.actionForSwipeCompletionPercentage(swipeCompletionPercentage: completionPercentage)
            break
        case .ended:
            let distance = gestureRecognizer.translation(in: self.superview!.superview!)
            let completionPercentage = distance.x / (self.superview!.superview!.frame.width / 2)
            if completionPercentage >= CGFloat(Constants.kSwipeViewCompletionTrigger) {
                let timing = UISpringTimingParameters(mass: CGFloat(Constants.kSwipeViewBounceBackMass), stiffness: CGFloat(Constants.kSwipeViewBounceBackStiffness), damping: CGFloat(Constants.kSwipeViewBounceBackDamping), initialVelocity: CGVector(dx: 0.0, dy: 0.0))
                let animator = UIViewPropertyAnimator(duration: 0.0, timingParameters: timing)
                animator.addAnimations {
                    let rotationAngle = CGFloat(Constants.kSwipeViewRotationAngle) * CGFloat(M_PI_2) / 180
                    let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
                    self.transform = rotationTransform
                    self.center.x = self.superview!.superview!.frame.width * CGFloat(Constants.kSwipeViewCompletionWidthMultiplier)
                    self.center.y = self.superview!.superview!.frame.width * CGFloat(Constants.kSwipeViewCompletionHeightMultiplier)
                }
                animator.addCompletion({ (animatingPosition) in
                    self.delegate?.swipeViewDidFinishSwiping(swipeRight: true)
                    self.layer.shouldRasterize = false
                    self.removeFromSuperview()
                })
                animator.startAnimation()
            } else if completionPercentage <= CGFloat(Constants.kSwipeViewCompletionTrigger) * -1.0 {
                let timing = UISpringTimingParameters(mass: CGFloat(Constants.kSwipeViewBounceBackMass), stiffness: CGFloat(Constants.kSwipeViewBounceBackStiffness), damping: CGFloat(Constants.kSwipeViewBounceBackDamping), initialVelocity: CGVector(dx: 0.0, dy: 0.0))
                let animator = UIViewPropertyAnimator(duration: 0.0, timingParameters: timing)
                animator.addAnimations {
                    let rotationAngle = -1.0 * CGFloat(Constants.kSwipeViewRotationAngle) * CGFloat(M_PI_2) / 180
                    let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
                    self.transform = rotationTransform
                    self.center.x = -1.0 * self.superview!.superview!.frame.width * CGFloat(Constants.kSwipeViewCompletionWidthMultiplier)
                    self.center.y = self.superview!.superview!.frame.width * CGFloat(Constants.kSwipeViewCompletionHeightMultiplier)
                }
                animator.addCompletion({ (animatingPosition) in
                    self.delegate?.swipeViewDidFinishSwiping(swipeRight: false)
                    self.layer.shouldRasterize = false
                    self.removeFromSuperview()
                })
                animator.startAnimation()
            } else {
                let timing = UISpringTimingParameters(mass: CGFloat(Constants.kSwipeViewBounceBackMass), stiffness: CGFloat(Constants.kSwipeViewBounceBackStiffness), damping: CGFloat(Constants.kSwipeViewBounceBackDamping), initialVelocity: CGVector(dx: 0.0, dy: 0.0))
                let animator = UIViewPropertyAnimator(duration: 0.0, timingParameters: timing)
                animator.addAnimations {
                    let rotationTransform = CGAffineTransform(rotationAngle: 0)
                    self.transform = rotationTransform
                    self.center = self.startingCenter!
                }
                animator.addCompletion({ (animatingPosition) in
                    self.layer.shouldRasterize = false
                })
                animator.startAnimation()
            }
            break
        default:
            break
        }
    }

}
