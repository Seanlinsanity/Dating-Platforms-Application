//
//  RegisterView.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/7.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class RegisterView: UIStackView {
    var registerViewModel: RegisterViewModel! {
        didSet{
            setupRegisterViewModelObserver()
        }
    }
    var presentImagePicker: (() -> ())?
    
    let selectedPhotoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        btn.setTitle("Select Photo", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 300).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 275).isActive = true
        btn.layer.cornerRadius = 16
        btn.backgroundColor = .white
        btn.imageView?.contentMode = .scaleAspectFill
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return btn
    }()
    
    let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.setTitle("Register", for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btn.layer.cornerRadius = 22
        btn.setTitleColor(.gray, for: .disabled)
        btn.backgroundColor = .lightGray
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return btn
    }()
    
    let nameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter full name"
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter full name"
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spacing = 8

        addArrangedSubview(selectedPhotoButton)
        addArrangedSubview(verticalStackView)
    }
    
    @objc private func handleRegister() {
        self.superview?.endEditing(true)
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.showHUD(error: error)
                return
            }
            
            print("successfully register uid", result?.user.uid)
        }
    }
    
    private func showHUD(error: Error) {
        let hud = JGProgressHUD()
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self)
        hud.dismiss(afterDelay: 4)
    }
    
    private func setupRegisterViewModelObserver() {
        registerViewModel?.isFormValidObserver.bind(observer: { [unowned self] (isFormValid) in
            guard let isFormValid = isFormValid else { return }
            self.registerButton.isEnabled = isFormValid
            if isFormValid {
                self.registerButton.backgroundColor = UIColor(red: 200/255, green: 0/255, blue: 80/255, alpha: 1)
                self.registerButton.setTitleColor(.white, for: .normal)
            } else {
                self.registerButton.backgroundColor = .lightGray
                self.registerButton.setTitleColor(.gray, for: .disabled)
            }
        })
        
        registerViewModel.bindableImage.bind(observer: { [unowned self] (image) in
            self.selectedPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        })
    }
    
    @objc private func handleSelectPhoto() {
        presentImagePicker?()
    }
    
    @objc private func handleTextChange(textField: UITextField) {
        if textField == nameTextField {
            registerViewModel.name = textField.text
        } else if textField == emailTextField {
            registerViewModel.email = textField.text
        } else {
            registerViewModel.password = textField.text
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
