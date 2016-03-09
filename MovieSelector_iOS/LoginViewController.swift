//
//  LoginViewController.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/8/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var signInButton: UIButton!
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var usernameGlyph: UIButton!
    @IBOutlet var usernameDivider: UIView!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        signInButton.layer.cornerRadius = 25.0
        signInButton.layer.masksToBounds = true
        
        usernameTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == usernameTextField) {
            usernameGlyph.tintColor = UIColor.yellowColor()
            usernameDivider.backgroundColor = UIColor.yellowColor()
        }
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
