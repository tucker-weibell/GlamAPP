//
//  NewMessageViewController.swift
//  Glam
//
//  Created by Student on 11/20/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit
import Parse

class NewMessageViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    

    struct GlobalVariable{
        static var currentItem = ""
    }
    var users: [String] = []
    var searchUsers: [String] = []
    var addresses = [String]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFUser.query()
        query?.whereKey("type", equalTo: "business")
        do {
            let results: [PFObject] = try (query?.findObjects())!
            for name in results {
                users.append(name["username"] as! String)
            }
        } catch {
            print(error)
        }
        
        let nextQuery = PFUser.query()
        query?.whereKey("type", equalTo: "customer")
        do {
            let result: [PFObject] = try (nextQuery?.findObjects())!
            for name in result {
                users.append(name["username"] as! String)
            }
        } catch {
            print(error)
        }
        
        users = Array(Set(users))
        users.sort()
        let user = PFUser.current()
        let username = user?.username
        users = users.filter({$0 != username})
    }
    
    @IBAction func search(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SearchCategory = storyBoard.instantiateViewController(withIdentifier: "TabBarControllerCustomer") as! UITabBarController
        self.present(SearchCategory, animated: true, completion: nil)
    }
    
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension NewMessageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchUsers.count
        } else {
            return users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newMessageCell")
        if searching {
            cell?.textLabel?.text = searchUsers[indexPath.row]
        }
        else {
            cell?.textLabel?.text = users[indexPath.row]
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        MessageCustomerViewController.GlobalVars.selectedItem = currentCell.textLabel!.text!
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SearchProfileViewController = storyBoard.instantiateViewController(withIdentifier: "navToChat") as! UINavigationController
        self.present(SearchProfileViewController, animated: true, completion: nil)
    }
    
    
}

extension NewMessageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchUsers = users.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
        self.searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
