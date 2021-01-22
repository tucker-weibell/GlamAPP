//
//  HomeCustomerViewController.swift
//  Glam
//
//  Created by Student on 10/29/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit

class HomeCustomerViewController: UIViewController {
    
    struct GlobalVarible {
        static var buttonClicked = ""
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func wedding(_ sender: Any) {
        GlobalVarible.buttonClicked = "wedding"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "categorynavcustomer") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
    
    @IBAction func family(_ sender: Any) {
        GlobalVarible.buttonClicked = "family"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "categorynavcustomer") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
    
    @IBAction func event(_ sender: Any) {
        GlobalVarible.buttonClicked = "event"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "categorynavcustomer") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
    
    @IBAction func portrait(_ sender: Any) {
        GlobalVarible.buttonClicked = "portrait"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "categorynavcustomer") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
    
    @IBAction func sport(_ sender: Any) {
        GlobalVarible.buttonClicked = "sport"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "categorynavcustomer") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
    
    @IBAction func other(_ sender: Any) {
        GlobalVarible.buttonClicked = "other"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "categorynavcustomer") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
}
