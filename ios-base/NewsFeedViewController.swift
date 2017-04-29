//
//  NewsFeedViewController.swift
//  ios-base
//

import UIKit
import Parse
import SVProgressHUD

class NewsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    
    // An array containing all the queried posts from Parse.
    var posts = [PFObject]()
    
    // Called right before the view appears.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // shows the navigation bar and hides the back button.
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        // Sets the text for the title bar.
        self.title = "News Feed"
        
        // Starts a loading indicator.
        SVProgressHUD.show()
        
        // Querying Parse for posts.
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
                
                // Cannot change UI in the background
                // Getting the main thread and dismissing the loading indicator.
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            } else {
                // Display details of the failure to the user.
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            }
        }
    }
    
    // Called right after the view loads.
    // This is called after "viewWillAppear"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering the tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "newsFeedCell")
        
        // Creating the left and right navigation buttons.
        let leftButtonItem = UIBarButtonItem.init(
            title: "View Profile",
            style: .done,
            target: self,
            action: #selector(NewsFeedViewController.viewOwnProfile)
        )
        self.navigationItem.leftBarButtonItem = leftButtonItem
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "New Post",
            style: .done,
            target: self,
            action: #selector(NewsFeedViewController.addNewPost)
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
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
    
    // Call viewProfile on current user..
    func viewOwnProfile() {
        viewProfile(user: PFUser.current()!)
    }
    
    // View profile for a user based on the paramter.
    // Launches the Profile View.
    func viewProfile(user: PFUser) {
        let profileViewController = ProfileViewController(inputUser: user)
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    // Launch the New Post View.
    func addNewPost() {
        let newPostVC = NewPostViewController()
        self.navigationController?.pushViewController(newPostVC, animated: true)
    }
    
    // MARK --  Table View Delegate Methods.
    
    // Enters editing mode
    func editingMode() {
        // Only admins can edit posts.
        if let isAdmin = PFUser.current()?["isAdmin"] as? Bool {
            self.tableView?.setEditing(isAdmin, animated: true)
        }
    }
    
    // Exists editing mode.
    func endEditingMode() {
        self.tableView?.setEditing(false, animated: true)
    }
    
    // Setting the edit style for each row.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            do {
                // Try to delete posts.
                try self.posts[indexPath.row].delete()
            } catch {
                // Otherwise say that it failed.
                SVProgressHUD.showError(withStatus: "Post could not be deleted. Please try again")
            }
        }
    }
    
    // Number of rows in the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // equal to the number of queried posts.
        return self.posts.count
    }
    
    // Sets the height for a row in the table.
    // Ideally this is dynamic based on the amount of content in the post.
    // Here we have hard-coded it to 150.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // Setting the content for each cell in the table.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the Post Object from the global array.
        let pfObject = self.posts[indexPath.row]
        
        // Create a post using the Post Class.
        let post = Post(postName: pfObject["postName"] as! String,
                        user: pfObject["user"] as! PFUser,
                        content: pfObject["content"] as! String,
                        timeStamp: pfObject["timeStamp"] as! String)
        
        // https://developer.apple.com/reference/uikit/uitableview/1614891-dequeuereusablecell
        // Check out the link above to learn more about dequeue cells.
        if let cell = self.tableView?.dequeueReusableCell(withIdentifier: "newsFeedCell") as? NewsFeedTableViewCell {
            cell.loadData(post: post, parent: self)
            return cell
        }
        
        let cell = NewsFeedTableViewCell(style: .default, reuseIdentifier: "newsFeedCell")
        cell.loadData(post: post, parent: self)
        
        return cell
    }
    
}
