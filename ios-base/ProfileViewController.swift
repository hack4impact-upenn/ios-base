//
//  ProfileViewController.swift
//  ios-base
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let signOutButton = UIButton(type: UIButtonType.roundedRect)
    private let profileImageButton = UIButton(type: UIButtonType.custom)
    var user: PFUser
    
    let imagePicker = UIImagePickerController()
    
    init(inputUser: PFUser?) {
        if inputUser != nil {
            // if not nil then we should use the user
            // that was passed in as a parameter.
            self.user = inputUser!
        } else {
            // if nil we should use the current user.
            self.user = PFUser.current()!
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // create an empty user
        self.user = PFUser.current()!
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        func centerForBelow(_ v : UIView) -> CGPoint {
            return CGPoint(x: v.center.x, y: v.center.y + v.frame.size.height + Spacing.ProfileText)
        }
        
        // Fetching the users information.
        // Must be wrapped in a try/catch in case it fails. 
        // This is not async. 
        do {
            try self.user.fetchIfNeeded()
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        // Setup name
        nameLabel.text = self.user.username
        nameLabel.sizeToFit()
        nameLabel.textColor = UIColor.darkGray
        nameLabel.center = self.view.center
        nameLabel.center.y += Spacing.ProfileText
        self.view.addSubview(nameLabel)
        
        // Setup email
        emailLabel.text = self.user.email
        emailLabel.sizeToFit()
        emailLabel.textColor = UIColor.darkGray
        emailLabel.center = centerForBelow(nameLabel)
        self.view.addSubview(emailLabel)
        
        // Setup signout
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.sizeToFit()
        signOutButton.center = centerForBelow(emailLabel)
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        self.view.addSubview(signOutButton)
        
        // Setup profile picture
        profileImageButton.frame.size = CGSize(width: 150, height: 150)
        profileImageButton.center = self.view.center
        profileImageButton.frame.origin.y = 100
        profileImageButton.layer.cornerRadius = 12
        profileImageButton.layer.masksToBounds = true
        profileImageButton.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        
        // This should be done in background.
        // Setting the button image
        
        let userImage = self.user["profPic"] as! PFObject
        
        do {
            try userImage.fetchIfNeeded()
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        let userImageFile = userImage["imageFile"] as! PFFile
        userImageFile.getDataInBackground {
            (imageData, error) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.profileImageButton.setImage(image, for: UIControlState.normal)
                }
            }
        }
        
        self.view.addSubview(profileImageButton)
        
        // Allows for the ability to change profile picture
        imagePicker.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signOutButtonTapped() {
        // Logging the user out.
        PFUser.logOut()
        
        // Going back to the root view controller
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func imageTapped() {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImageButton.setImage(pickedImage, for: UIControlState.normal)
            
            let imageData = UIImageJPEGRepresentation(pickedImage, 0.5)
            let imageFile = PFFile(name:"image.png", data:imageData!)
            
            let profPic = PFObject(className:"ProfilePictures")
            profPic["imageName"] = "Prof Pic"
            profPic["imageFile"] = imageFile
            profPic.saveInBackground {
                (succeeded, error) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                    // Show the errorString somewhere and let the user try again.
                } else {
                    self.user["profPic"] = profPic
                    self.user.saveInBackground()
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
