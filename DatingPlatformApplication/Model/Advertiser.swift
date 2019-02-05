//
//  Advertiser.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/5.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

struct Advertiser: ProduceCardViewModel {
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    func generateCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: title, attributes: [.font : UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "\n" + brandName, attributes: [.font : UIFont.systemFont(ofSize: 24, weight: .regular)]))
        return CardViewModel(imageNames: [posterPhotoName], attributeString: attributedText, textAlignment: .center)
    }
}
