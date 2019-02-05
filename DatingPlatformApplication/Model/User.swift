//
//  User.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/4.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

struct User: ProduceCardViewModel {
    let name: String
    let age: Int
    let profession: String
    let imageName: String

    func generateCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font : UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "   \(profession)", attributes: [.font : UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "\n\(String(describing: age))", attributes: [.font : UIFont.systemFont(ofSize: 24, weight: .semibold)]))        
        return CardViewModel(imageName: imageName, attributeString: attributedText, textAlignment: .left)
    }
}
