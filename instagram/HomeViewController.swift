//
//  HomeViewController.swift
//  
//
//  Created by Carlos Osco Huaricapcha on 3/5/16.
//
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mediaArr: [PFObject]?
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 220.0
        //tableView.rowHeight = 520;
        
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("_created_at")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if media != nil {
                self.mediaArr = media
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mediaArr != nil {
            return mediaArr!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostTableViewCell", forIndexPath: indexPath) as! PostTableViewCell
        let media = mediaArr![indexPath.row]
        cell.postCaption.text = media["caption"] as? String
        let userImageFile = media["media"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.postImageView.image = image
                }
            }
        }
        return cell
    }
    
    func refresh(sender: AnyObject) {
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("_created_at")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if media != nil {
                self.mediaArr = media
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func logOutClicked(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            if error == nil {
                print("User logged out")
                self.performSegueWithIdentifier("logOutSegueID", sender: nil)
            }
            else {
                print("Error while logging out")
            }
        }
        
    }
    
    
}





//import UIKit
//import Parse
//
//class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    
//    var mediaArr: [PFObject]?
//    var refreshControl: UIRefreshControl
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//        
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//        
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        //tableView.estimatedRowHeight = 220.0
//        //tableView.rowHeight = 520;
//        
//        //tableView.rowHeight = UITableViewAutomaticDimension
//        
//        self.refreshControl = UIRefreshControl()
//        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
//        self.tableView.addSubview(refreshControl)
//        
//        let query = PFQuery(className: "UserMedia")
//        query.orderByDescending("_created_at")
//        query.limit = 20
//        
//        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
//            if media != nil {
//                self.mediaArr = media
//                self.tableView.reloadData()
//            } else {
//                print(error?.localizedDescription)
//            }
//        }
//        
//        
//        
//    }
//    
//    
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    // MARK: - Table view data source
//    
//    //    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//    //        // #warning Incomplete implementation, return the number of sections
//    //        return 0
//    //    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if mediaArr != nil {
//            return mediaArr!.count
//        }
//        else {
//            return 0
//        }
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("PostTableViewCell", forIndexPath: indexPath) as! PostTableViewCell
//        let media = mediaArr![indexPath.row]
//        cell.postCaption.text = media["caption"] as? String
//        let userImageFile = media["media"] as! PFFile
//        userImageFile.getDataInBackgroundWithBlock {
//            (imageData: NSData?, error: NSError?) -> Void in
//            if error == nil {
//                if let imageData = imageData {
//                    let image = UIImage(data:imageData)
//                    cell.postImageView.image = image
//                }
//            }
//        }
//        return cell
//    }
//    
//    func refresh(sender: AnyObject) {
//        let query = PFQuery(className: "UserMedia")
//        query.orderByDescending("_created_at")
//        query.limit = 20
//        
//        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
//            if media != nil {
//                self.mediaArr = media
//                self.tableView.reloadData()
//            } else {
//                print(error?.localizedDescription)
//            }
//        }
//        self.refreshControl.endRefreshing()
//    }
//    
//    //    @IBAction func logOutClicked(sender: AnyObject) {
//    //        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
//    //            if error == nil {
//    //                print("User logged out")
//    //                self.performSegueWithIdentifier("logOutSegueID", sender: nil)
//    //            }
//    //            else {
//    //                print("Error while logging out")
//    //            }
//    //        }
//    //
//    //    }
//    
//    
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//    // Return false if you do not want the specified item to be editable.
//    return true
//    }
//    */
//    
//    /*
//    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//    if editingStyle == .Delete {
//    // Delete the row from the data source
//    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//    } else if editingStyle == .Insert {
//    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//    }
//    */
//    
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//    
//    }
//    */
//    
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//    // Return false if you do not want the item to be re-orderable.
//    return true
//    }
//    */
//    
//    /*
//    // MARK: - Navigation
//    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    // Get the new view controller using segue.destinationViewController.
//    // Pass the selected object to the new view controller.
//    }
//    */
//    
//}
