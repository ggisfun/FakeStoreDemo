//
//  SignInViewController.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/6/28.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var SignInWithGoogleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UISetUp()
        setupDismissKeyboardGesture()
    }
    
    func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false  // 點按按鈕等不會被吃掉
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func UISetUp() {        
        let emailPadding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: emailTextField.frame.height))
        emailTextField.leftView = emailPadding
        emailTextField.leftViewMode = .always
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.masksToBounds = true
        
        let passwordPadding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: passwordTextField.frame.height))
        passwordTextField.leftView = passwordPadding
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.masksToBounds = true
    }

}
