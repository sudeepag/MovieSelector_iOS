//
//  NavigationController.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 4/8/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import UIKit
import MediumMenu

class NavigationController: UINavigationController {
    
    var menu: MediumMenu?

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        navigationBarHidden = true

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewControllerWithIdentifier("Home") as! ViewController
        setViewControllers([homeViewController], animated: false)
        
        let item1 = MediumMenuItem(title: "Home") {
            let homeViewController = storyboard.instantiateViewControllerWithIdentifier("Home") as! ViewController
            self.setViewControllers([homeViewController], animated: false)
        }
        
        let item2 = MediumMenuItem(title: "Settings") {
            let settingsViewController = storyboard.instantiateViewControllerWithIdentifier("Settings") as! SettingsViewController
            self.setViewControllers([settingsViewController], animated: false)
        }
        
        let item3 = MediumMenuItem(title: "Log Out") {
            print("CALLED")
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        menu = MediumMenu(items: [item1, item2, item3], forViewController: self)
        menu?.backgroundColor = UIColor(rgba: "#009688")
        menu?.highlightTextColor = UIColor(rgba: "#F9C00E")
        
    }
    
    func showMenu() {
        menu?.show()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension UINavigationBar {
//    public override func sizeThatFits(size: CGSize) -> CGSize {
//        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 60)
//    }
//}
