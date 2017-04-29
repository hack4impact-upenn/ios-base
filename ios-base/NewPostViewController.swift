//
//  NewPostViewController.swift
//  ios-base
//

import UIKit
import Parse
import SVProgressHUD

class NewPostViewController: UIViewController, UITextFieldDelegate {
    
    private let postTitleField = CustomTextField()
    private let postField = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.MainColor
        
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        // Creating the Post Title
        postTitleField.frame = CGRect(x:0, y:0, width: width - 40, height:30)
        postTitleField.center = CGPoint(x: width/2, y: height*2/11)
        postTitleField.backgroundColor = UIColor.white
        postTitleField.layer.cornerRadius = Spacing.CornerRadius
        postTitleField.delegate = self
        postTitleField.keyboardType = UIKeyboardType.default
        postTitleField.returnKeyType = UIReturnKeyType.done
        postTitleField.placeholder = "Post Title"
        self.view.addSubview(postTitleField)
        
        // Creating the post label
        postField.frame = CGRect(x:0, y:0, width: width - 40, height:170)
        postField.center = CGPoint(x: width/2, y: height*2/5)
        postField.backgroundColor = UIColor.white
        postField.layer.cornerRadius = Spacing.CornerRadius
        postField.keyboardType = UIKeyboardType.default
        postField.returnKeyType = UIReturnKeyType.done
        postField.text = "Today I..."
        postField.font = .systemFont(ofSize:16)
        self.view.addSubview(postField)
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "Post",
            style: .done,
            target: self,
            action: #selector(postButtonTapped)
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
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
            if ((error) != nil) {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
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
