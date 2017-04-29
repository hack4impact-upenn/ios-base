//
//  NewsFeedViewController.swift
//  ios-base
//

import UIKit
import Parse
import SVProgressHUD

class NewsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    var posts = [PFObject]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.title = "News Feed"
        
        SVProgressHUD.show()
        
        let query = PFQuery(className:"Post")
        // want the posts in reverse order
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground {
            (objects, error) -> Void in
            if error == nil {
                // The find succeeded.
                // sets the objects to a global variable
                self.posts = objects!
                // refreshes the posts in the tableview
                self.tableView?.reloadData()
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            } else {
                // Log details of the failure
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
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
        
        // add gesture recognizer for deletion
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(endEditingMode))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        // add gesture recognizer for ending deletion
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(editingMode))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        self.view.isUserInteractionEnabled = true
    }
    
    func editingMode() {
        if let isAdmin = PFUser.current()?["isAdmin"] as? Bool {
            self.tableView?.setEditing(isAdmin, animated: true)
        }
    }
    
    func endEditingMode() {
        self.tableView?.setEditing(false, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            do {
                try self.posts[indexPath.row].delete()
            } catch {
                SVProgressHUD.showError(withStatus: "Post could not be deleted. Please try again")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pfObject = self.posts[indexPath.row]
        let post = Post(postName: pfObject["postName"] as! String,
                        user: pfObject["user"] as! PFUser,
                        content: pfObject["content"] as! String,
                        timeStamp: pfObject["timeStamp"] as! String)
        
        if let cell = self.tableView?.dequeueReusableCell(withIdentifier: "newsFeedCell") as? NewsFeedTableViewCell {
            cell.loadData(post: post, parent: self)
            return cell
        }
        
        let cell = NewsFeedTableViewCell(style: .default, reuseIdentifier: "newsFeedCell")
        cell.loadData(post: post, parent: self)
        
        return cell
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
        return self.posts.count
    }
    
    func addNewPost() {
        let newPostVC = NewPostViewController()
        self.navigationController?.pushViewController(newPostVC, animated: true)
    }
    
}
