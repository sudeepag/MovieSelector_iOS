//
//  MenuViewController.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/28/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
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

}
