//
//  SearchProfileViewController.swift
//  Glam
//
//  Created by Student on 11/10/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit
import Parse

class SearchProfileViewController: UIViewController {
    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var emailField: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    var text = SearchCustomerViewController.GlobalVariable.currentItem
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = text
        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePic.bounds.width / 2
        
        
        let query = PFUser.query()
        query?.whereKey("username", equalTo: String(text))
        query?.includeKey("email")
        do {
            let results: [PFObject] = try (query?.findObjects())!
            print(results[0])
            emailField.text = (results[0]["Email"] as! String)
            if results[0]["picture"] != nil {
                let data = results[0]["picture"] as! PFFileObject
                print(data)
                do {
                    let imageData = try data.getData()
                    print(imageData)
                    let image = UIImage(data: imageData)
                    profilePic.image = image
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }


    @IBAction func bbutton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func arrowbutton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
