//
//  NewPostViewController.swift
//  ios-base
//

import UIKit
import Parse

class NewPostViewController: UIViewController, UITextFieldDelegate {
    
    private let postTitleField = CustomTextField()
    private let postField = CustomTextField()
    private let postButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        // Creating the Post Title
        postTitleField.frame = CGRect(x:0, y:0, width:240, height:30)
        postTitleField.center = CGPoint(x: width/2, y: height*1/3)
        postTitleField.backgroundColor = UIColor.white
        postTitleField.layer.cornerRadius = Spacing.CornerRadius
        postTitleField.layer.borderColor = UIColor.black.cgColor
        postTitleField.layer.borderWidth = 1.0
        postTitleField.delegate = self
        postTitleField.keyboardType = UIKeyboardType.default
        postTitleField.returnKeyType = UIReturnKeyType.done
        postTitleField.placeholder = "Post Title"
        self.view.addSubview(postTitleField)
        
        // Creating the password label
        postField.frame = CGRect(x:0, y:0, width:240, height:120)
        postField.center = CGPoint(x: width/2, y: height*1/2)
        postField.backgroundColor = UIColor.white
        postField.layer.cornerRadius = Spacing.CornerRadius
        postField.delegate = self
        postField.layer.borderColor = UIColor.black.cgColor
        postField.layer.borderWidth = 1.0
        postField.keyboardType = UIKeyboardType.default
        postField.returnKeyType = UIReturnKeyType.done
        postField.placeholder = "Post here!"
        self.view.addSubview(postField)
        
        // Creating the post button
        postButton.setTitle("Post", for: .normal)
        postButton.frame = CGRect(x: 0, y: 0, width: 120, height: 30)
        postButton.center = CGPoint(x: width/2, y: height*3/4)
        postButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        postButton.backgroundColor = UIColor.white
        postButton.setTitleColor(Color.MainColor, for: .normal)
        postButton.layer.cornerRadius = Spacing.CornerRadius
        self.view.addSubview(postButton)
        
        // Creating a keyboard dismiss
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
    }
    
    func postButtonTapped() {
        // Create a new post.
        
        let postName = postTitleField.text
        let user = PFUser.current()
        let content = postField.text
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let timeStamp = dateFormatter.string(from: NSDate() as Date)
        
        let post = Post(postName: postName!, user: user!, content: content!, timeStamp: timeStamp)
        post.pfObject.saveInBackground {
            (success, error) -> Void in
            if (error) {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 0)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 0)
    }
    
    func animateViewMoving (up: Bool, moveValue: CGFloat){
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: up ? -moveValue : moveValue)
        })
    }
    
    
}
