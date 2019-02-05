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
            imageView.image = UIImage(named: cardViewModel.imageNames.first ?? "")
            infomationLabel.textAlignment = cardViewModel.textAlignment
            infomationLabel.attributedText = cardViewModel.attributeString
            
            if cardViewModel.imageNames.count > 1 {
                (0..<cardViewModel.imageNames.count).forEach({ (_) in
                    let barView = UIView()
                    barView.backgroundColor = deselectedColor
                    barStackView.addArrangedSubview(barView)
                })
                barStackView.arrangedSubviews.first?.backgroundColor = .white
            }
            
            setupImageIndexObserver()
        }
    }
    
    fileprivate func setupImageIndexObserver(){
        cardViewModel.imageIndexObserver = { [weak self] (image, index) in
            self?.imageView.image = image
            self?.barStackView.arrangedSubviews.forEach { (view) in
                view.backgroundColor = self?.deselectedColor
            }
            self?.barStackView.arrangedSubviews[index].backgroundColor = .white
        }
    }
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "anna"))
    fileprivate let infomationLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.numberOfLines = 0
        return lb
    }()
    fileprivate let barStackView = UIStackView()
    fileprivate let gradientLayer = CAGradientLayer()
    //Configuration
    private let threshold: CGFloat = 80
    fileprivate let deselectedColor = UIColor(white: 0, alpha: 0.1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupGesture()
        
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    private func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(gesture: UIPanGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > (frame.width / 2)
        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextIndex()
        } else {
            cardViewModel.goToPreviousIndex()
        }
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
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
        
        setupBarStackView()
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
        
        addSubview(infomationLabel)
        infomationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16), size: .zero)
        
    }
    
    private func setupBarStackView(){
        addSubview(barStackView)
        barStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: CGSize(width: 0, height: 4))
        barStackView.distribution = .fillEqually
        barStackView.spacing = 4
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
