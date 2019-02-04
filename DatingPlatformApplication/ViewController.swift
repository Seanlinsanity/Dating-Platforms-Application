//
//  ViewController.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/2.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let bottomStackView = HomeBottomControlsStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        setupDummyCards()
    }
    
    private func setupDummyCards() {
        let cardView = CardView()
        cardsDeckView.addSubview(cardView)
        cardView.fillSuperview()
    }
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomStackView])
        overallStackView.axis = .vertical
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.bringSubviewToFront(cardsDeckView)
    }

}

