//
//  HomeTopControlsStackView.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/3.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {
    let settingButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let messageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    let fireImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        [settingButton, UIView(), fireImageView, UIView(), messageButton].forEach { (view) in
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
