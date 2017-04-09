//
//  NewsFeedViewController.swift
//  ios-base
//

import UIKit
import Parse

class NewsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.title = "News Feed"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "newsFeedCell")
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "New Post",
            style: .done,
            target: self,
            action: #selector(NewsFeedViewController.addNewPost)
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        let leftButtonItem = UIBarButtonItem.init(
            title: "View Profile",
            style: .done,
            target: self,
            action: #selector(NewsFeedViewController.viewOwnProfile)
        )
        
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a sample news feed post
        let post = Post(postName: "Hello!", username: "kasra", content: "Sup fam! This is my post yo", timeStamp: "4 April 2017")
        let user = PFUser()
        user.username = "kasra"
        return NewsFeedTableViewCell(post: post, user: user, parent: self)
        
        
    }
    
    func viewOwnProfile() {
        let profileViewController = ProfileViewController(inputUser: nil)
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func viewProfile(user: PFUser) {
        let profileViewController = ProfileViewController(inputUser: user)
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // obtain number from Parse
        return 10
    }
    
    func addNewPost() {
        let newPostVC = NewPostViewController()
        self.navigationController?.pushViewController(newPostVC, animated: true)
    }
    
}
