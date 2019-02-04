//
//  CardView.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/4.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit
enum Direction: Int {
    case left = 0
    case right = 1
}

class CardView: UIView {
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "anna"))
    //Configuration
    private let threshold: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            self.handleChanged(gesture)
        case .ended:
            self.handleEnded(gesture)
        default:
            ()
        }
        
    }
    
    private func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degree: CGFloat = translation.x / 20
        let angle = degree * .pi / 180
        let rotationalTransformation  = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    private func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let panDirection: Direction = gesture.translation(in: nil).x > 0 ? .right : .left
        let shouldDismiss = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if (shouldDismiss){
                self.frame = CGRect(x: panDirection == .right ? 1000 : -1000, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
        }) { (_) in
            self.transform = .identity
            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
