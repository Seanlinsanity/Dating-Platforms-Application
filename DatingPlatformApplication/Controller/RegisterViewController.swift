//
//  RegisterViewController.swift
//  DatingPlatformApplication
//
//  Created by SEAN on 2019/2/6.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        registerViewModel.bindableImage.value = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

class RegisterViewController: UIViewController {
    let registerView = RegisterView()
    let gradienLayer = CAGradientLayer()
    
    let registerViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNotificationObserver()
        setupGesture()
        setupRegister()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradienLayer.frame = view.bounds
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            registerView.axis = .horizontal
        } else {
            registerView.axis = .vertical
        }
    }
    
    private func setupRegister() {
        registerView.registerViewModel = registerViewModel
        registerView.presentImagePicker = { [unowned self] in
            let imagePickController = UIImagePickerController()
            imagePickController.delegate = self
            self.present(imagePickController, animated: true, completion: nil)
        }
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleKeyboardShow(notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = frame.cgRectValue
        let bottomSpace = view.frame.height - registerView.frame.origin.y - registerView.frame.height
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
        
    }
    
    @objc private func handleKeyboardHide(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    
    private func setupGesture(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc func handleTapDismiss() {
        self.view.endEditing(true)
    }
    
    private func setupLayout(){
        setupGradientLayer()

        registerView.axis = .vertical
        view.addSubview(registerView)
        registerView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        registerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupGradientLayer(){
        let topColor = UIColor(red: 235/255, green: 91/255, blue: 95/255, alpha: 1)
        let bottomColor = UIColor(red: 229/255, green: 0, blue: 114/255, alpha: 1)
        gradienLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradienLayer.locations = [0, 1]
        view.layer.addSublayer(gradienLayer)
        gradienLayer.frame = view.bounds
    }
    
    deinit {
        print("deinit registerViewController")
        NotificationCenter.default.removeObserver(self)
    }
}
