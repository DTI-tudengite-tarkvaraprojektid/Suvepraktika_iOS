//
//  ViewController.swift
//  information1
//
//  Created by dev on 11/06/2018.
//  Copyright © 2018 dev. All rights reserved.
//

import UIKit

class UserInputInfo: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var lastNameTextBox: UITextField!
    @IBOutlet weak var phoneNumberBox: UITextField!
    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var addressTextBox: UITextField!
    @IBOutlet weak var lblValidationMessage: UILabel!
    @IBOutlet weak var termsSwitch: UISwitch!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lblValidationMessage.isHidden = true
        nameTextBox.delegate = self
        lastNameTextBox.delegate = self
        phoneNumberBox.delegate = self
        emailTextBox.delegate = self
        addressTextBox.delegate = self
        enterButton.isEnabled = false
        addressTextBox.isEnabled = false
        
    }
    
    
    @IBAction func enterButton(_ sender: Any) {
        
        lblValidationMessage.isHidden = true
        guard let _ = nameTextBox.text, nameTextBox.text?.count != 0 else{
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Please enter your first name!"
            return
            
        }
        
        guard let _ = lastNameTextBox.text, lastNameTextBox.text?.count != 0 else{
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Please enter your last name!"
            return
            
        }
        
        guard let _ = phoneNumberBox.text, phoneNumberBox.text?.count != 0 else{
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Please enter your phone number!"
            return
            
        }
        
        guard let email = emailTextBox.text, emailTextBox.text?.count != 0 else{
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Please enter your email!"
            return
            
        }
        
        if isValidEmail(emailID: email) == false {
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Please enter valid email address"
        }
        
        view.endEditing(true)
    }
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    @IBOutlet weak var selectedSegment: UISegmentedControl!
    
    @IBAction func selectedSegmentTapped(_ sender: Any) {
        
        let getIndex = selectedSegment.selectedSegmentIndex
        
        switch (getIndex) {
        case 0:
            self.addressTextBox.isEnabled = false
        case 1:
            self.addressTextBox.isEnabled = true
        default:
            print("test")
        }
    }

    @IBAction func termsSwitch(_ sender: UISwitch) {
        enterButton.isEnabled = sender.isOn
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneNumberBox.resignFirstResponder()
        // Hides the keypad when clicked away from the pad
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UserInputInfo.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
