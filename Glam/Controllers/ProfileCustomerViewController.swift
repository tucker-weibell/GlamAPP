//
//  ProfileCustomerViewController.swift
//  Glam
//
//  Created by Student on 10/29/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit
import Parse
import MapKit

class ProfileCustomerViewController: UIViewController {
    @IBOutlet weak var ProfilePic: UIImageView!
   // @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProfilePic.layer.masksToBounds = true
        ProfilePic.layer.cornerRadius = ProfilePic.bounds.width / 2
        
        let query = PFUser.query()
        let user = PFUser.current()
        let username = user?.username
        usernameLabel.text = username
        query?.whereKey("username", equalTo: username!)
        do {
            let results = try query?.findObjects()
            if results![0]["picture"] != nil {
                let data = results![0]["picture"] as! PFFileObject
                do {
                    let imageData = try data.getData()
                    let image = UIImage(data: imageData)
                    ProfilePic.image = image
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }


    
    func loadStartScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginOrCreateViewController = storyBoard.instantiateViewController(withIdentifier: "LoginOrCreateViewController")
        self.present(LoginOrCreateViewController, animated: true, completion: nil)
    }
    
    @IBAction func signOut(_ sender: Any) {
        MessageCustomerViewController.GlobalVars.myTimer.invalidate()
        let logoutAlert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: UIAlertController.Style.alert)
        
        logoutAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            PFUser.logOutInBackground { (error: Error?) in
                if (error == nil){
                    self.loadStartScreen()
                }else{
                    if let descrip = error?.localizedDescription{
                        print(descrip)
                    }else{
                        print("Error logging out!")
                    }
                    
                }
            }
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action: UIAlertAction!) in
            //Do nothing
        }))
        
        self.present(logoutAlert, animated: true, completion: nil)
    }
    
}
