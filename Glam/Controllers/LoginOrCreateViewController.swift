//
//  LoginOrCreateViewController.swift
//  Glam
//
//  Created by Student on 10/29/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit
import Parse

class LoginOrCreateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = PFUser.current()
        if currentUser != nil {
            loadHomeScreen()
        }
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
    
    @IBAction func CreateAnAccountButton(_ sender: Any) {
        performSegue(withIdentifier: "CreateAnAccountButton", sender: self)
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        performSegue(withIdentifier: "LoginButton", sender: self)
    }
    

}
