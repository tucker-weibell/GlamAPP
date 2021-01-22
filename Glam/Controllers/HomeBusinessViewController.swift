//
//  HomeBusinessViewController.swift
//  Glam
//
//  Created by Student on 10/29/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit

class HomeBusinessViewController: UIViewController {
    
    struct GlobalVariable {
        static var buttonClicked = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func wedding(_ sender: Any) {
        GlobalVariable.buttonClicked = "wedding"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "businesscategorynav") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
    
    @IBAction func family(_ sender: Any) {
        GlobalVariable.buttonClicked = "family"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "businesscategorynav") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
    
    @IBAction func event(_ sender: Any) {
        GlobalVariable.buttonClicked = "event"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "businesscategorynav") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
    
    @IBAction func portrait(_ sender: Any) {
        GlobalVariable.buttonClicked = "portrait"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "businesscategorynav") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
    
    @IBAction func sport(_ sender: Any) {
        GlobalVariable.buttonClicked = "sport"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "businesscategorynav") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
    
    @IBAction func other(_ sender: Any) {
        GlobalVariable.buttonClicked = "other"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "businesscategorynav") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
}
