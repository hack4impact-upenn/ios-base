//
//  ForgotViewController.swift
//  ios-base
//
//  Created by Kyle Rosenbluth on 4/25/17.
//  Copyright © 2017 Kyle Rosenbluth. All rights reserved.
//

import UIKit
import Parse

class ForgotViewController: UIViewController {
    private let emlField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.MainColor
        
        
        let msg = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 150))
        msg.textAlignment = .center
        msg.numberOfLines = 0
        msg.text = "Enter your email to get that password reset!"
        self.view.addSubview(msg)
        
        emlField.frame.origin = CGPoint(x: 0, y: 250)
        emlField.borderStyle = .bezel
        emlField.backgroundColor = UIColor.white
        emlField.placeholder = "Email address"
        emlField.sizeToFit()
        emlField.frame.size.width = self.view.frame.size.width - 30
        self.view.addSubview(emlField)
        
        
        let subBtn = UIButton(type: .system)
        subBtn.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        subBtn.center = self.view.center
        subBtn.setTitle("Submit", for: .normal)
        subBtn.addTarget(self, action: #selector(submitReset), for: .touchUpInside)
        self.view.addSubview(subBtn)
        // Do any additional setup after loading the view.
    }
    
    func submitReset() {
        PFUser.requestPasswordResetForEmail(inBackground: emlField.text ?? "", block: { (b, e) in
        })
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
