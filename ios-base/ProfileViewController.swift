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
    private let profileImageView = UIImageView()
    var user: PFUser
    
    init(inputUser: PFUser?) {
        // check if there is an input user to show
        if let user = inputUser {
            self.user = user
        } // otherwise check if there is a currently logged in user
        else if let user = PFUser.current() {
            self.user = user
        } // otherwise show nothing
        else {
            self.user = PFUser()
            self.user.username = "No user found"
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // create an empty user
        self.user = PFUser()
        self.user.username = "No user found"
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        func centerForBelow(_ v : UIView) -> CGPoint {
            return CGPoint(x: v.center.x, y: v.center.y + v.frame.size.height + Spacing.ProfileText)
        }
        
        // Setup name
        self.nameLabel.text = self.user.username
        self.nameLabel.sizeToFit()
        self.nameLabel.textColor = UIColor.darkGray
        self.nameLabel.center = self.view.center
        self.nameLabel.center.y += Spacing.ProfileText
        self.view.addSubview(nameLabel)
        
        // Setup email
        self.emailLabel.text = self.user.email
        self.emailLabel.sizeToFit()
        self.emailLabel.textColor = UIColor.darkGray
        self.emailLabel.center = centerForBelow(nameLabel)
        self.view.addSubview(emailLabel)
        
        // Setup signout
        self.signOutButton.setTitle("Sign Out", for: .normal)
        self.signOutButton.sizeToFit()
        self.signOutButton.center = centerForBelow(emailLabel)
        self.view.addSubview(signOutButton)
        
        // Setup profile picture
        let prof_pic = "https://scontent-lga3-1.xx.fbcdn.net/v/t1.0-9/15822924_10210243463137294_4969821814341284468_n.jpg?oh=720a875e07bab5bd4227c91e57728193&oe=5927BD68"
        
        if let url = URL(string: prof_pic), let d = try? Data(contentsOf: url) {
            let img = UIImage(data: d)
            self.profileImageView.image = img
            self.profileImageView.frame.size = CGSize(width: 150, height: 150)
            self.profileImageView.center = self.view.center
            self.profileImageView.frame.origin.y = 100
            self.profileImageView.layer.cornerRadius = 12
            self.profileImageView.layer.masksToBounds = true
            self.view.addSubview(profileImageView)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
