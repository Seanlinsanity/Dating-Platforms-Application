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

//ViewModel is supposed to represent the state of the view
class CardViewModel {
    let imageNames: [String]
    let attributeString: NSAttributedString
    let textAlignment: NSTextAlignment
    private var imageIndex = 0 {
        didSet {
            let image = UIImage(named: imageNames[imageIndex])
            imageIndexObserver?(image, imageIndex)
        }
    }
    
    init(imageNames: [String], attributeString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributeString = attributeString
        self.textAlignment = textAlignment
    }
    
    //Reactive Programming
    var imageIndexObserver: ((UIImage?, Int) -> ())?
    
    func advanceToNextIndex() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func goToPreviousIndex() {
        imageIndex = max(imageIndex - 1, 0)
    }
}
