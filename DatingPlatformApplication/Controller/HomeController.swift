//
//  ViewController.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/2.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let bottomStackView = HomeBottomControlsStackView()
    
    var cardViewModels: [CardViewModel] = {
        let models: [ProduceCardViewModel] = [
            User(name: "Anna", age: 25, profession: "Photographer", imageName: "anna"),
            Advertiser(title: "讓他們捕捉精彩片刻", brandName: "Apple", posterPhotoName: "appleAd"),
            User(name: "Jane", age: 25, profession: "Athlete", imageName: "jane"),
            Advertiser(title: "讓他們捕捉精彩片刻", brandName: "Apple", posterPhotoName: "appleAd")
        ]
        let viewModels = models.map({ (producer) -> CardViewModel in
            return producer.generateCardViewModel()
        })
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        setupDummyCards()
    }
    
    private func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView()
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
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

