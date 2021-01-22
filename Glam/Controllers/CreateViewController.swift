//
//  CreateViewController.swift
//  Glam
//
//  Created by Student on 10/29/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AlreadyHaveAnAccountButton(_ sender: Any) {
        performSegue(withIdentifier: "AlreadyHaveAnAccountButton", sender: self)
    }
    
    @IBAction func CreateBusinessAccountButton(_ sender: Any) {
        performSegue(withIdentifier: "CreateBusinessAccountButton", sender: self)
    }
    
    @IBAction func CreateCustomerAccountButton(_ sender: Any) {
        performSegue(withIdentifier: "CreateCustomerAccountButton", sender: self)
    }
}
