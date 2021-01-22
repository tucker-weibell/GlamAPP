//
//  LoginViewController.swift
//  Glam
//
//  Created by Student on 10/29/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ErrorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
        UsernameTextField.text = ""
        PasswordTextField.text = ""
        ErrorMessage.text = ""
    }
    
    private func setTextFields() {
        UsernameTextField.delegate = self
        PasswordTextField.delegate = self
    }
    
    @IBAction func DontHaveAnAccountButton(_ sender: Any) {
        performSegue(withIdentifier: "DontHaveAnAccountButton", sender: self)
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
    
    @IBAction func SignInButton(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: UsernameTextField.text!, password: PasswordTextField.text!) { (user, error) in
            if user != nil {
                self.loadHomeScreen()
            }else{
                if let descrip = error?.localizedDescription{
                    self.ErrorMessage.text = descrip
                    print(descrip)
                }
            }
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        SignInButton(self)
        return true
    }
}
