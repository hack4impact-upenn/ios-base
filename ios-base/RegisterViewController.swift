import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    private let userTextField = UITextField()
    private let passwordTextField = UITextField()
    private let confirmPWTextField = UITextField()
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

        let mainColor =
            UIColor.init(colorLiteralRed: 0, green: 130.0/256, blue: 203.0/256, alpha: 1.0)
        self.view.backgroundColor = mainColor

        let width = self.view.frame.size.width
        let height = self.view.frame.size.height

        // Creating the username label
        userTextField.frame = (frame: CGRect(x:0, y:0, width:240, height:30))
        userTextField.center = CGPoint(x: width/2, y: height*1/4)
        userTextField.backgroundColor = UIColor.white
        userTextField.layer.cornerRadius = 4
        userTextField.delegate = self
        userTextField.keyboardType = UIKeyboardType.default
        userTextField.returnKeyType = UIReturnKeyType.done
        userTextField.placeholder = "  Email"
        self.view.addSubview(userTextField)

        // Creating the password label
        passwordTextField.frame = (frame: CGRect(x:0, y:0, width:240, height:30))
        passwordTextField.center = CGPoint(x: width/2, y: height*1/3)
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.delegate = self
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.placeholder = "  Password"
        self.view.addSubview(passwordTextField)

        // Creating the ConfirmPW label
        confirmPWTextField.frame = (frame: CGRect(x:0, y:0, width:240, height:30))
        confirmPWTextField.center = CGPoint(x: width/2, y: height*5/12)
        confirmPWTextField.backgroundColor = UIColor.white
        confirmPWTextField.layer.cornerRadius = 4
        confirmPWTextField.delegate = self
        confirmPWTextField.keyboardType = UIKeyboardType.default
        confirmPWTextField.isSecureTextEntry = true
        confirmPWTextField.returnKeyType = UIReturnKeyType.done
        confirmPWTextField.placeholder = "  Confirm Password"
        self.view.addSubview(confirmPWTextField)

        // Creating the register button
        registerButton.setTitle("Sign Up", for: .normal)
        registerButton.frame = (frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        registerButton.center = CGPoint(x: width/2, y: height*13/24)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.backgroundColor = UIColor.white
        registerButton.setTitleColor(mainColor, for: .normal)
        registerButton.layer.cornerRadius = 10
        self.view.addSubview(registerButton)
    }

    func registerButtonTapped() {
        // Create a new user.
        // Validate User Inputs
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

    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration: TimeInterval = 0.3
        let movement: CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}
