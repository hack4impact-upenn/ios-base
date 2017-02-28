//
//  ProfileViewController.swift
//  ios-base
//
//  Created by Kyle Rosenbluth on 2/28/17.
//  Copyright © 2017 Kyle Rosenbluth. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let signOutButton = UIButton(type: UIButtonType.roundedRect)
    let profileImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        func centerForBelow(_ v : UIView) -> CGPoint {
            return CGPoint(x: v.center.x, y: v.center.y + v.frame.size.height + 40)
        }
        
        // Setup name
        nameLabel.text = "Kyle Rosenbluth"
        nameLabel.sizeToFit()
        nameLabel.textColor = UIColor.darkGray
        nameLabel.center = self.view.center
        nameLabel.center.y += 40
        self.view.addSubview(nameLabel)
        
        // Setup email
        emailLabel.text = "kyle.rosenbluth@gmail.com"
        emailLabel.sizeToFit()
        emailLabel.textColor = UIColor.darkGray
        emailLabel.center = centerForBelow(nameLabel)
        self.view.addSubview(emailLabel)
        
        // Setup signout
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.sizeToFit()
        signOutButton.center = centerForBelow(emailLabel)
        self.view.addSubview(signOutButton)
        
        // Setup profile picture
        let prof_pic = "https://scontent-lga3-1.xx.fbcdn.net/v/t1.0-9/15822924_10210243463137294_4969821814341284468_n.jpg?oh=720a875e07bab5bd4227c91e57728193&oe=5927BD68"
        if let url = URL(string: prof_pic), let d = try? Data(contentsOf: url) {
            let img = UIImage(data: d)
            profileImageView.image = img
            profileImageView.frame.size = CGSize(width: 150, height: 150)
            profileImageView.center = self.view.center
            profileImageView.frame.origin.y = 100
            profileImageView.layer.cornerRadius = 12
            profileImageView.layer.masksToBounds = true
            self.view.addSubview(profileImageView)
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
