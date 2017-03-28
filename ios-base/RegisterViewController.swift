//
//  RegisterViewController.swift
//  ios-base
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    private let userTextField = CustomTextField()
    private let passwordTextField = CustomTextField()
    private let confirmPWTextField = CustomTextField()
    private let registerButton = UIButton(type: .system)
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Create New Account"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        self.view.backgroundColor = Color.MainColor

        // Creating the username label
        userTextField.frame = (frame: CGRect(x: 0, y: 0, width: 240, height: 30))
        userTextField.center = CGPoint(x: width/2, y: height*1/4)
        userTextField.backgroundColor = UIColor.white
        userTextField.layer.cornerRadius = Spacing.CornerRadius
        userTextField.delegate = self
        userTextField.keyboardType = UIKeyboardType.default
        userTextField.returnKeyType = UIReturnKeyType.done
        userTextField.placeholder = "Email"
        self.view.addSubview(userTextField)

        // Creating the password label
        passwordTextField.frame = (frame: CGRect(x:0, y:0, width:240, height:30))
        passwordTextField.center = CGPoint(x: width/2, y: height*1/3)
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.layer.cornerRadius = Spacing.CornerRadius
        passwordTextField.delegate = self
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.placeholder = "Password"
        self.view.addSubview(passwordTextField)

        // Creating the ConfirmPW label
        confirmPWTextField.frame = (frame: CGRect(x:0, y:0, width:240, height:30))
        confirmPWTextField.center = CGPoint(x: width/2, y: height*5/12)
        confirmPWTextField.backgroundColor = UIColor.white
        confirmPWTextField.layer.cornerRadius = Spacing.CornerRadius
        confirmPWTextField.delegate = self
        confirmPWTextField.keyboardType = UIKeyboardType.default
        confirmPWTextField.isSecureTextEntry = true
        confirmPWTextField.returnKeyType = UIReturnKeyType.done
        confirmPWTextField.placeholder = "Confirm Password"
        self.view.addSubview(confirmPWTextField)

        // Creating the register button
        registerButton.setTitle("Sign Up", for: .normal)
        registerButton.frame = (frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        registerButton.center = CGPoint(x: width/2, y: height*13/24)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.backgroundColor = UIColor.white
        registerButton.setTitleColor(Color.MainColor, for: .normal)
        registerButton.layer.cornerRadius = Spacing.CornerRadius
        self.view.addSubview(registerButton)
        
        // Creating a keyboard dismiss
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
    }

    func registerButtonTapped() {
        // Create a new user.
        // Validate User Inputs
        let newsFeedVC = NewsFeedViewController()
        self.navigationController?.pushViewController(newsFeedVC, animated: true)
    }

    func dismissKeyboard() {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return false
    }
}
