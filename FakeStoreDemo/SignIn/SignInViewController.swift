//
//  SignInViewController.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/6/28.
//

import UIKit
import Combine

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var SignInWithGoogleButton: UIButton!
    
    private var viewModel = SignInViewModel()
    private var cancellables = Set<AnyCancellable>()
    
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

    @IBAction func signInButtonPressed(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        guard !email.isEmpty, !password.isEmpty else {
            showAlert(title: "提示訊息", message: "請填寫所有欄位")
            return
        }
        
        let request = SignInRequest(
            email: email,
            password: password
        )
        
        viewModel.login(with: request)
            .sink { completion in
                switch completion {
                case .finished:
                    print("登入成功")
                case .failure(let error):
                    print("登入失敗：\(error)")
                    self.showAlert(title: "登入失敗", message: "請確認帳密或稍後再試")
                }
            } receiveValue: { response in
                if !response.access_token.isEmpty, !response.refresh_token.isEmpty {
                    self.showAlert(title: "登入成功", message: "歡迎回來！") {
                        self.goToHome()
                    }
                } else {
                    self.showAlert(title: "登入失敗", message: "請稍後再試")
                }
            }.store(in: &cancellables)
    }
    
    func goToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true)
        }
    }
}
