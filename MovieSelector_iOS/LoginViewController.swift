//
//  LoginViewController.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/8/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
import SwiftLoader

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var signInButton: UIButton!
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var usernameGlyph: UIButton!
    @IBOutlet var usernameDivider: UIView!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordGlyph: UIButton!
    @IBOutlet var passwordDivider: UIView!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        signInButton.layer.cornerRadius = 25.0
        signInButton.layer.masksToBounds = true
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField == usernameTextField) {
            usernameGlyph.tintColor = UIColor.whiteColor()
            usernameDivider.backgroundColor = UIColor.whiteColor()
        } else if (textField == passwordTextField) {
            passwordGlyph.tintColor = UIColor.whiteColor()
            passwordDivider.backgroundColor = UIColor.whiteColor()
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == usernameTextField) {
            usernameGlyph.tintColor = UIColor(rgba: "#f9c00e")
            usernameDivider.backgroundColor = UIColor(rgba: "#f9c00e")
        } else if (textField == passwordTextField) {
            passwordGlyph.tintColor = UIColor(rgba: "#f9c00e")
            passwordDivider.backgroundColor = UIColor(rgba: "#f9c00e")
        }
    }

    @IBAction func signInButtonSelected(sender: AnyObject) {
        SwiftLoader.show(animated: true)
        NetworkManager.sharedManager.authUser(usernameTextField.text!, password: passwordTextField.text!) { (success) -> Void in
            if (success) {
                SwiftLoader.hide()
                print(MovieManager.sharedManager.movieList)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeVC = storyboard.instantiateViewControllerWithIdentifier("Home") as! ViewController
                let navController = NavigationController(rootViewController: homeVC)
                self.presentViewController(navController, animated:true, completion: nil)
            } else {
                SwiftLoader.hide()
                let alert = UIAlertView(title: "Error", message: "Unable to log in. Please ensure that your email and password are correct.", delegate: self, cancelButtonTitle: "Okay")
                alert.show()
            }
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

}
