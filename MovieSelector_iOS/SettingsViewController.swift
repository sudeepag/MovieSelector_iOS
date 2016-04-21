//
//  MenuViewController.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/28/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func menuButtonSelected(sender: AnyObject) {
        let controller = navigationController as! NavigationController
        controller.showMenu()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = UserManager.sharedManager.currentUser
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Email"
            let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: cell.frame.height))
            textField.autocapitalizationType = .None
            textField.textAlignment = .Right
            textField.text = user.email
            textField.placeholder = "me@mail.com"
            cell.accessoryView = textField
        case 1:
            cell.textLabel?.text = "Password"
            let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: cell.frame.height))
            textField.secureTextEntry = true
            textField.textAlignment = .Right
            textField.text = user.password
            textField.placeholder = "•••••••"
            cell.accessoryView = textField
        case 2:
            cell.textLabel?.text = "Major"
            let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: cell.frame.height))
            textField.textAlignment = .Right
            textField.placeholder = "Computer Science"
            textField.text = user.major
            cell.accessoryView = textField
        case 3:
            cell.textLabel?.text = "User Description"
            let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: cell.frame.height))
            textField.textAlignment = .Right
            textField.placeholder = "Something about myself"
            textField.text = user.desc
            cell.accessoryView = textField
        default:
            return cell
        }
        return cell
    }

}
