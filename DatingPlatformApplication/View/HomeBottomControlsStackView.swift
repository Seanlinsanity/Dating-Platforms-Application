//
//  HomeBottomControlsStackView.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/3.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
    let subControls = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (image) -> UIView in
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        for view in subControls {
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
