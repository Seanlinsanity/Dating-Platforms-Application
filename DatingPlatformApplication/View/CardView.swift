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
    var cardViewModel: CardViewModel! {
        didSet{
            imageView.image = UIImage(named: cardViewModel.imageName)
            infomationLabel.textAlignment = cardViewModel.textAlignment
            infomationLabel.attributedText = cardViewModel.attributeString
        }
    }
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "anna"))
    fileprivate let infomationLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.numberOfLines = 0
        return lb
    }()
    //Configuration
    private let threshold: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupGesture()
        
    }
    
    private func setupGesture() {
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
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if (shouldDismiss){
                self.frame = CGRect(x: panDirection == .right ? 600 : -600, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
        }) { (_) in
            self.transform = .identity
            if (shouldDismiss) {
                self.removeFromSuperview()
            }
//            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    private func setupLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(infomationLabel)
        infomationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16), size: .zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
