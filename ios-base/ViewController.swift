//
//  ViewController.swift
//  ios-base
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    private let userTextField = CustomTextField()
    private let passwordTextField = CustomTextField()
    private let loginButton = UIButton(type: .system)
    private let registerButton = UIButton(type: .system)
    private let logoImageView = UIImageView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        self.view.backgroundColor = Color.MainColor

        // Creating the imageView
        logoImageView.frame = (frame: CGRect(x:0, y:0, width:width/2, height:width/2))
        logoImageView.center = CGPoint(x: width/2, y:height*1/3)
        logoImageView.image = #imageLiteral(resourceName: "h4i_square_white")
        self.view.addSubview(logoImageView)
        
        
        // Creating the username label
        userTextField.frame = (frame: CGRect(x:0, y:0, width:240, height:30))
        userTextField.center = CGPoint(x: width/2, y: height*7/12)
        userTextField.backgroundColor = UIColor.white
        userTextField.layer.cornerRadius = Spacing.CornerRadius
        userTextField.delegate = self
        userTextField.keyboardType = UIKeyboardType.default
        userTextField.returnKeyType = UIReturnKeyType.done
        userTextField.placeholder = "Email"
        self.view.addSubview(userTextField)
        
        // Creating the password label
        passwordTextField.frame = (frame: CGRect(x:0, y:0, width:240, height:30))
        passwordTextField.center = CGPoint(x: width/2, y: height*2/3)
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.layer.cornerRadius = Spacing.CornerRadius
        passwordTextField.delegate = self
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.placeholder = "Password"
        self.view.addSubview(passwordTextField)
        
        // Creating the login button
        loginButton.setTitle("Login", for: .normal)
        loginButton.frame = (frame: CGRect(x: 0, y: 0, width: 240, height: 30))
        loginButton.center = CGPoint(x: width/2, y: height*3/4)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.backgroundColor = UIColor.white
        loginButton.setTitleColor(Color.MainColor, for: .normal)
        loginButton.layer.cornerRadius = Spacing.CornerRadius
        self.view.addSubview(loginButton)
        
        // Creating the register button
        registerButton.setTitle("Sign Up", for: .normal)
        registerButton.frame = (frame: CGRect(x: 0, y: 0, width: 240, height: 30))
        registerButton.center = CGPoint(x: width/2, y: height*11/12)
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
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }

    func loginButtonTapped() {
        // validate user input against database
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

    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 100)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 100)
    }

    func animateViewMoving (up: Bool, moveValue: CGFloat){
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: up ? -moveValue : moveValue)
        })
    }
}
