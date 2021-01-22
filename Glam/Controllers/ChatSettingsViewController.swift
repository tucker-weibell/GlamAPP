//
//  ChatSettingsViewController.swift
//  Glam
//
//  Created by Student on 11/19/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit
import Parse

class ChatSettingsViewController: UIViewController {
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var orange: UIButton!
    @IBOutlet weak var yellow: UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var teal: UIButton!
    @IBOutlet weak var skyBlue: UIButton!
    @IBOutlet weak var chalkBlue: UIButton!
    @IBOutlet weak var purple: UIButton!
    @IBOutlet weak var pink: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    var colorList = ""
    var dictionary = [String:String]()
    
    struct GlobalVars {
        static var selectedColor = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorList = ""
        red.layer.cornerRadius = 20
        orange.layer.cornerRadius = 20
        yellow.layer.cornerRadius = 20
        green.layer.cornerRadius = 20
        teal.layer.cornerRadius = 20
        skyBlue.layer.cornerRadius = 20
        chalkBlue.layer.cornerRadius = 20
        purple.layer.cornerRadius = 20
        pink.layer.cornerRadius = 20
        
        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePic.bounds.width / 2
        username.text = MessageCustomerViewController.GlobalVars.selectedItem
        
        
        let query = PFUser.query()
        query?.whereKey("username", equalTo: MessageCustomerViewController.GlobalVars.selectedItem)
        do {
            let result = try query?.findObjects()
            let user = result![0]
            if user["picture"] != nil {
                let data: PFFileObject = user["picture"] as! PFFileObject
                do {
                    let imageData = try data.getData()
                    let image = UIImage(data: imageData)
                    profilePic.image = image
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
        
        let user = PFUser.current()
        let name = user?.username
        let newQuery = PFUser.query()
        newQuery?.whereKey("username", equalTo: name!)
        do {
            let result = try newQuery?.findObjects()
            if result![0]["chatColor"] != nil {
                let file: PFFileObject = result![0]["chatColor"] as! PFFileObject
                do {
                    let data = try file.getData()
                    colorList = String(decoding: data, as: UTF8.self)
                    let cvsRows = colorList.components(separatedBy: "!NEWLINE!")
                    print(cvsRows)
                    for row in cvsRows {
                        print(row)
                        var itemsRow = row.components(separatedBy: "!SEPERATE!")
                        dictionary[itemsRow[0]] = itemsRow[1]
                    }
                    
                }
            }
        } catch {
            print(error)
        }
        
        if dictionary[MessageCustomerViewController.GlobalVars.selectedItem] != nil {
            let currentColor = dictionary[MessageCustomerViewController.GlobalVars.selectedItem]
            let image = UIImage(named: "icons8-checkmark-48")
            switch(currentColor) {
                case "red":
                    red.setBackgroundImage(image, for: .normal)
                case "orange":
                    orange.setBackgroundImage(image, for: .normal)
                case "yellow":
                    yellow.setBackgroundImage(image, for: .normal)
                case "green":
                    green.setBackgroundImage(image, for: .normal)
                case "teal":
                    teal.setBackgroundImage(image, for: .normal)
                case "skyBlue":
                    skyBlue.setBackgroundImage(image, for: .normal)
                case "chalkBlue":
                    chalkBlue.setBackgroundImage(image, for: .normal)
                case "purple":
                    purple.setBackgroundImage(image, for: .normal)
                case "pink":
                    pink.setBackgroundImage(image, for: .normal)
                default:
                    break
            }
        }
    
   }
    
    
    func setColor() {
        
        if dictionary[MessageCustomerViewController.GlobalVars.selectedItem] != nil {
            let image = UIImage()
            let color = dictionary[MessageCustomerViewController.GlobalVars.selectedItem]
            switch(color) {
                case "red":
                    red.setBackgroundImage(image, for: .normal)
                case "orange":
                    orange.setBackgroundImage(image, for: .normal)
                case "yellow":
                    yellow.setBackgroundImage(image, for: .normal)
                case "green":
                    green.setBackgroundImage(image, for: .normal)
                case "teal":
                    teal.setBackgroundImage(image, for: .normal)
                case "skyBlue":
                    skyBlue.setBackgroundImage(image, for: .normal)
                case "chalkBlue":
                    chalkBlue.setBackgroundImage(image, for: .normal)
                case "purple":
                    purple.setBackgroundImage(image, for: .normal)
                case "pink":
                    pink.setBackgroundImage(image, for: .normal)
                default:
                    break
            }
        }
        
        dictionary[MessageCustomerViewController.GlobalVars.selectedItem] = GlobalVars.selectedColor
        var colorString = ""
        var x = 0
        for key in dictionary.keys {
            if x == 0 {
                colorString.append(key + "!SEPERATE!" + dictionary[key]!)
            } else {
                colorString.append("!NEWLINE!" + key + "!SEPERATE!" + dictionary[key]!)
            }
            x = x + 1
        }
        let data = Data(colorString.utf8)
        let file = PFFileObject(name: "chatColor.txt", data: data)
        let user = PFUser.current()
        let name = user?.username
        let query = PFUser.query()
        query?.whereKey("username", equalTo: name!)
        do {
            let result = try query?.findObjects()
            result![0]["chatColor"] = file
            do {
                try result![0].save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    
    
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func red(_ sender: Any) {
        let image = UIImage(named: "icons8-checkmark-48")
        red.setBackgroundImage(image, for: UIControl.State.normal)
        
        
        GlobalVars.selectedColor = "red"
        setColor()
    }
    @IBAction func orange(_ sender: Any) {
        let image = UIImage(named: "icons8-checkmark-48")
        orange.setBackgroundImage(image, for: UIControl.State.normal)
        

        
        GlobalVars.selectedColor = "orange"
        setColor()
    }
    @IBAction func yellow(_ sender: Any) {
        let image = UIImage(named: "icons8-checkmark-48")
        yellow.setBackgroundImage(image, for: UIControl.State.normal)
        
        
        GlobalVars.selectedColor = "yellow"
        setColor()
    }
    @IBAction func green(_ sender: Any) {
        let image = UIImage(named: "icons8-checkmark-48")
        green.setBackgroundImage(image, for: UIControl.State.normal)

        
        GlobalVars.selectedColor = "green"
        setColor()
    }
    @IBAction func teal(_ sender: Any) {
        let image = UIImage(named: "icons8-checkmark-48")
        teal.setBackgroundImage(image, for: UIControl.State.normal)
        
        
        GlobalVars.selectedColor = "teal"
        setColor()
    }
    @IBAction func skyBlue(_ sender: Any) {
        let image = UIImage(named: "icons8-checkmark-48")
        skyBlue.setBackgroundImage(image, for: UIControl.State.normal)

        
        GlobalVars.selectedColor = "skyBlue"
        setColor()
    }
    @IBAction func chalkBlue(_ sender: Any) {
        let image = UIImage(named: "icons8-checkmark-48")
        chalkBlue.setBackgroundImage(image, for: UIControl.State.normal)

        GlobalVars.selectedColor = "chalkBlue"
        setColor()
    }
    @IBAction func purple(_ sender: Any) {
        let image = UIImage(named: "icons8-checkmark-48")
        purple.setBackgroundImage(image, for: UIControl.State.normal)

        
        GlobalVars.selectedColor = "purple"
        setColor()
    }
    @IBAction func pink(_ sender: Any) {
        let image = UIImage(named: "icons8-checkmark-48")
        pink.setBackgroundImage(image, for: UIControl.State.normal)
        
        GlobalVars.selectedColor = "pink"
        setColor()
    }
    
    
    
//COLORS
    
}
