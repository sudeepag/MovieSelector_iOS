//
//  CreateAccountViewController.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 4/11/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var signUpButton: UIButton!
    var majors: [String] = ["Computer Science", "Electrical Engineering", "Mechanical Engineering", "Industrial and Systems Engineering", "Math", "Physics", "Chemistry", "Chemical Engineering"]
    @IBOutlet var majorTextField: UITextField!
    @IBOutlet var majorPickerView: UIPickerView!
    @IBOutlet var fieldsView: UIView!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.layer.cornerRadius = 25.0
        signUpButton.layer.masksToBounds = true
        
        majorTextField.delegate = self
        majorPickerView.dataSource = self
        majorPickerView.delegate = self
        majorPickerView.hidden = true
        majorPickerView.alpha = 0
        
    }
    
    @IBAction func backButtonSelected(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
   
    @IBAction func signUpButtonSelected(sender: AnyObject) {
        
    }
    
    func validateFields() {
        var field = ""
        let alert = UIAlertView(title: "Error", message: "Unable to register. Please enter a valid \(field)", delegate: self, cancelButtonTitle: "Okay")
        if (emailTextField.text == "") {
            field = "email"
            alert.show()
        } else if (passwordTextField.text == "") {
            field = "password"
            alert.show()
        }
        
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return majors.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return majors[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        majorTextField.text = majors[row]
        animatePickerDown()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if (textField == majorTextField) {
            if (textField.text == "") {
                textField.text = majors[0]
            }
            animatePickerUp()
            majorPickerView.hidden = false
            return false
        }
        return true
    }
    
//    func textFieldDidEndEditing(textField: UITextField) {
//        if (textField == majorTextField) {
//            fieldsView.transform = CGAffineTransformMakeTranslation(0, 0)
//            logoImageView.transform = CGAffineTransformMakeTranslation(0, 0)
//        }
//    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (!majorPickerView.hidden) {
            animatePickerDown()
        }
    }
    
    func animatePickerUp() {
        majorPickerView.hidden = false
        UIView.animateWithDuration(0.3, animations: { 
            let translation = -(self.majorPickerView.frame.height-(self.view.frame.height - self.fieldsView.frame.maxY)) - 50
            self.fieldsView.transform = CGAffineTransformMakeTranslation(0, translation)
            self.logoImageView.transform = CGAffineTransformMakeTranslation(0, translation)
            self.majorPickerView.alpha = 1.0
            }) { (finished) in
                //
        }
    }
    
    func animatePickerDown() {
        UIView.animateWithDuration(0.3, animations: { 
            self.fieldsView.transform = CGAffineTransformMakeTranslation(0, 0)
            self.logoImageView.transform = CGAffineTransformMakeTranslation(0, 0)
            self.majorPickerView.alpha = 0
            }) { (finished) in
                self.majorPickerView.hidden = true
        }
        
    }

}
