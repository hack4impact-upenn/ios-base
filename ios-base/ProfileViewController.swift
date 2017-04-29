//
//  ProfileViewController.swift
//  ios-base
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let signOutButton = UIButton(type: UIButtonType.roundedRect)
    private let profileImageButton = UIButton(type: UIButtonType.system)
    var user: PFUser
    
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
        
        
        // Setup the image in the profile picture
        let default_pic = "https://scontent-lga3-1.xx.fbcdn.net/v/t1.0-9/15822924_10210243463137294_4969821814341284468_n.jpg?oh=720a875e07bab5bd4227c91e57728193&oe=5927BD68"
        
//        if {
//            
//        } else if let url = URL(string: default_pic), let d = try? Data(contentsOf: url) {
//            let img = UIImage(data: d)
//            profileImageButton.setImage(img, for: UIControlState.normal)
//        }
//        
//        profileImageButton.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControlState#>)
        
        self.view.addSubview(profileImageButton)
        
        
        
        
        
        // Setup profile picture
//
        
        
        
//        if let url = URL(string: prof_pic), let d = try? Data(contentsOf: url) {
//            let img = UIImage(data: d)
//            self.profileImageView.image = img
//            self.profileImageView.frame.size = CGSize(width: 150, height: 150)
//            self.profileImageView.center = self.view.center
//            self.profileImageView.frame.origin.y = 100
//            self.profileImageView.layer.cornerRadius = 12
//            self.profileImageView.layer.masksToBounds = true
//            self.view.addSubview(profileImageView)
//        }

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
}
