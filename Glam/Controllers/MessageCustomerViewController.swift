//
//  MessageCustomerViewController.swift
//  Glam
//
//  Created by Student on 10/29/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit
import Parse

class MessageCustomerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    struct GlobalVars {
        static var sender = [String]()
        static var reduced_sender = [String]()
        static var message = [String]()
        static var reduced_message = [String]()
        static var images = [UIImage]()
        static var result: [String:Int] = [:]
        static var state = [String]()
        static var selectedItem = ""
        static var myTimer = Timer()
    }
    
    @objc func refresh() {
        print("working")
        GlobalVars.reduced_message.removeAll()
        getData()
        tableView.reloadData()
    }
    
    func clearVars() {
        GlobalVars.sender.removeAll()
        GlobalVars.reduced_sender.removeAll()
        GlobalVars.message.removeAll()
        GlobalVars.reduced_message.removeAll()
        GlobalVars.images.removeAll()
        GlobalVars.result.removeAll()
        GlobalVars.state.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalVars.myTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
        clearVars()
        getData()
        tableView.reloadData()
        refresh()
    }
    
    func getData() {
        let user = PFUser.current()
        let name = user?.username
        print(name ?? "no-name-found")
        
        //try and get data from Messages Class
        let mySearch = PFQuery(className: "Messages")
        mySearch.whereKey("username", equalTo: name!)
        do {
            let result = try mySearch.findObjects()
            if result[0]["Messages"] != nil {
                let file: PFFileObject = result[0]["Messages"] as! PFFileObject
                do {
                    let data = try file.getData()
                    let string = String(decoding: data, as: UTF8.self)
                    print(string)
                    let cvsRows = string.components(separatedBy: "!NEWLINE!")
                    for row in cvsRows {
                        var itemsRow = row.components(separatedBy: "!SEPERATE!")
                        print(itemsRow)
                        GlobalVars.sender.append(itemsRow[0])
                        GlobalVars.message.append(itemsRow[1])
                        GlobalVars.state.append(itemsRow[2])
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        GlobalVars.result = zip(GlobalVars.sender, GlobalVars.sender.indices).reduce(into: [:], {dict, tuple in
            dict[tuple.0] = tuple.1
        })
        
        GlobalVars.reduced_sender = Array(Set(GlobalVars.sender))
        
        for sender in GlobalVars.reduced_sender {
            let index = GlobalVars.result[sender]
            GlobalVars.reduced_message.append(GlobalVars.message[index!])
        }
        
        for items in GlobalVars.reduced_sender {
            let query = PFUser.query()
            query?.whereKey("username", equalTo: items)
            do {
                let results = try query?.findObjects()
                for user in results! {
                    if user["picture"] != nil {
                        let data = user["picture"] as! PFFileObject
                        do {
                            let imageData = try data.getData()
                            let image = UIImage(data: imageData)
                            GlobalVars.images.append(image!)
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                    else {
                        let basicPic = UIImage(named: "unnamed")
                        GlobalVars.images.append(basicPic!)
                    }
                    
                }
            }
            catch {
                print(error)
            }
        }
    }
    
    
    @IBAction func newMessage(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "newMessageNav") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalVars.reduced_sender.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! CustomCell
        cell.recipientName.text = GlobalVars.reduced_sender[indexPath.item]
        cell.recipientDetail.text = GlobalVars.reduced_message[indexPath.item]
        cell.recipientImage.image = GlobalVars.images[indexPath.item]
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as! CustomCell
        GlobalVars.selectedItem = currentCell.recipientName.text!
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyBoard.instantiateViewController(withIdentifier: "navToChat") as! UINavigationController
        self.present(tableView, animated: true, completion: nil)
    }

}

