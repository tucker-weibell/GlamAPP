//
//  CreateBusinessAccountViewController.swift
//  Glam
//
//  Created by Student on 10/29/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit
import Parse

class CreateBusinessAccountViewController: UIViewController {
    @IBOutlet weak var UsernametextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    @IBOutlet weak var ErrorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
        UsernametextField.text = ""
        EmailTextField.text = ""
        PasswordTextField.text = ""
        ConfirmPasswordTextField.text = ""
        ErrorMessage.text = ""
    }
    
    private func setTextFields() {
        UsernametextField.delegate = self
        PasswordTextField.delegate = self
        EmailTextField.delegate = self
        ConfirmPasswordTextField.delegate = self
    }
    
    @IBAction func BackBusiness(_ sender: Any) {
        performSegue(withIdentifier: "BackBusiness", sender: self)
    }
    
    func loadHomeScreen() {
        let user = PFUser.current()
        if user!["type"] as! String == "customer" {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let TabBarControllerCustomer = storyBoard.instantiateViewController(withIdentifier: "TabBarControllerCustomer") as! UITabBarController
            self.present(TabBarControllerCustomer, animated: true, completion: nil)
        }
        else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let TabBarControllerBusiness = storyBoard.instantiateViewController(withIdentifier: "TabBarControllerBusiness") as! UITabBarController
            self.present(TabBarControllerBusiness, animated: true, completion: nil)
        }
    }
    
    @IBAction func CreateAccountButton(_ sender: Any) {
        if PasswordTextField.text?.count ?? 0 >= 8 {
            if PasswordTextField.text == ConfirmPasswordTextField.text {
                if EmailTextField.text != "" {
                    let user = PFUser()
                    let object:PFObject = PFObject(className: "Messages")
                    object["username"] = UsernametextField.text
                    do {
                        try object.save()
                    } catch {
                        print(error)
                    }
                    user.username = UsernametextField.text
                    user.password = PasswordTextField.text
                    user.email = EmailTextField.text
                    user["type"] = "business"
                    user["Email"] = EmailTextField.text
                    user.signUpInBackground { (success, error) in
                        if success{
                            self.loadHomeScreen()
                        }else{
                            if let descrip = error?.localizedDescription{
                                self.ErrorMessage.text = descrip
                                print(descrip)
                            }
                        }
                    }
                }
                else {
                    self.ErrorMessage.text = "Enter valid email address"
                }
            }
            else {
                self.ErrorMessage.text = "Passwords do not match"
            }
        }
        else {
            self.ErrorMessage.text = "Password must be 8 or more characters"
        }
    }
    

}

extension CreateBusinessAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        CreateAccountButton(self)
        return true
    }
}
