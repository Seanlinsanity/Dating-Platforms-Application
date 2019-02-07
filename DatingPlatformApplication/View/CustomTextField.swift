//
//  CustomTextField.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/6.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    let padding: CGFloat
    init(padding: CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
        layer.cornerRadius = 22
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 44)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
}
