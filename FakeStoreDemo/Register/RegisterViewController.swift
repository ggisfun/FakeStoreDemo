//
//  RegisterViewController.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/7/19.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var viewModel = RegisterViewModel()
    private var signInViewModel = SignInViewModel()
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
        let namePadding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: nameTextField.frame.height))
        nameTextField.leftView = namePadding
        nameTextField.leftViewMode = .always
        nameTextField.layer.cornerRadius = 15
        nameTextField.layer.masksToBounds = true
        
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
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            showAlert(title: "提示訊息", message: "請填寫所有欄位")
            return
        }
        
        let request = RegisterRequest(
            name: name,
            email: email,
            password: password,
            avatar: "https://picsum.photos/800"
        )
        
        viewModel.registerUser(with: request)
            .sink { completion in
                switch completion {
                case .finished:
                    print("註冊成功")
                case .failure(let error):
                    print("註冊失敗：\(error)")
                }
            } receiveValue: { response in
                print("成功註冊：\(response.name)")
                self.showAlert(title: "註冊成功", message: "歡迎, \(response.name)") {
                    let loginRequest = SignInRequest(email: email, password: password)
                    
                    self.signInViewModel.login(with: loginRequest)
                        .sink { loginCompletion in
                            switch loginCompletion {
                            case .finished:
                                print("登入完成")
                            case .failure(let loginError):
                                print("登入失敗：\(loginError)")
                                self.showAlert(title: "登入失敗", message: "請稍後再試")
                            }
                        } receiveValue: { loginResponse in
                            if !loginResponse.access_token.isEmpty,
                               !loginResponse.refresh_token.isEmpty {
                                
                                // 登入成功，進入主畫面
                                self.goToHome()
                            } else {
                                // 回傳成功但 token 為空，視為失敗
                                self.showAlert(title: "登入失敗", message: "請稍後再試")
                            }
                        }
                        .store(in: &self.cancellables)
                }
            }.store(in: &cancellables)
        
    }
    
    func goToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            homeVC.modalPresentationStyle = .fullScreen
            self.present(homeVC, animated: true)
        }
    }

}
