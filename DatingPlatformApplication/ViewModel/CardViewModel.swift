//
//  CardViewModel.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/5.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

protocol ProduceCardViewModel {
    func generateCardViewModel() -> CardViewModel
}

struct CardViewModel {
    let imageName: String
    let attributeString: NSAttributedString
    let textAlignment: NSTextAlignment
}
