//
//  RegisterViewModel.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/7.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

class RegisterViewModel {
    var bindableImage = Bindable<UIImage>()
    var isFormValidObserver = Bindable<Bool>()

    var name: String? {
        didSet {
            checkFormValidation()
        }
    }
    var email: String? {
        didSet {
            checkFormValidation()
        }
    }
    var password: String? {
        didSet {
            checkFormValidation()
        }
    }
    
    private func checkFormValidation() {
        let isFormValid = name?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver.value = isFormValid
    }
}
