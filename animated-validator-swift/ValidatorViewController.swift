//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBOutlet weak var SubmitButtonYConstraint: NSLayoutConstraint!
    
    var textFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textFields = [self.emailTextField,
                           self.emailConfirmationTextField,
                           self.phoneTextField,
                           self.passwordTextField,
                           self.passwordConfirmTextField ]
        
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        for textField in self.textFields {
            textField.delegate = self
        }
        
        self.submitButton.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        switch textField.accessibilityLabel! {
            
        case "emailTextField":
            if !textField.text!.containsString("@") || !textField.text!.containsString(".") { animateField(textField) }
            else { goodField(textField) }
            
        case "emailConfirmTextField":
            if textField.text != emailTextField.text || emailTextField.accessibilityIdentifier != "good" { animateField(textField) }
            else { goodField(textField) }
            
        case "phoneTextField":
            if Int(textField.text!) == nil { animateField(textField) }
            else { goodField(textField) }
            
        case "passwordTextField":
            if textField.text?.characters.count < 6 { animateField(textField) }
            else { goodField(textField) }
            
        case "passwordConfirmTextField":
            if textField.text != passwordTextField.text || phoneTextField.accessibilityIdentifier != "good" { animateField(textField) }
            else { goodField(textField) }
            
        default: break
            
        }
        
    }
    
    
    func animateField(textField: UITextField) {
        textField.accessibilityIdentifier = "bad"
        UIView.animateWithDuration(0.5, delay: 0, options: [.Autoreverse], animations: {
            textField.backgroundColor = UIColor.redColor()
            textField.transform = CGAffineTransformMakeScale(0.9, 0.9)
            UIView.setAnimationRepeatCount(2.0)
            self.view.layoutIfNeeded()
            }, completion: { (true) in
                textField.transform = CGAffineTransformMakeScale(1, 1)
                self.view.layoutIfNeeded()})
    }
    
    
    func goodField(textField: UITextField) {
        textField.accessibilityIdentifier = "good"
        textField.backgroundColor = UIColor.whiteColor()
        bringSubmitButtonUp()
    }
    
    
    func bringSubmitButtonUp() {
        let allFieldsGood = self.textFields.filter({$0.accessibilityIdentifier == "good"}).count == self.textFields.count
        if allFieldsGood {
            UIView.animateWithDuration(1, animations: {
                self.SubmitButtonYConstraint.constant = 0
                self.view.layoutIfNeeded()
                }, completion: { (true) in
                    self.submitButton.enabled = true})
        }
        
    }
    

}