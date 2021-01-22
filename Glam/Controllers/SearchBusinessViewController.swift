//
//  SearchBusinessViewController.swift
//  Glam
//
//  Created by Student on 10/29/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit
import Parse

class SearchBusinessViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var users = [String]()
    var searchUsers = [String]()
    var addresses = [String]()
    var searching = false
    
    struct GlobalVariable{
        static var currentItem = ""
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFUser.query()
        query?.whereKey("type", equalTo: "business")
        do {
            let results: [PFObject] = try (query?.findObjects())!
            for name in results {
                users.append(name["username"] as! String)
                addresses.append(name["address"] as! String)
            }
        } catch {
            print(error)
        }
        
    }
    
    
    @IBAction func nearMe(_ sender: Any) {
        performSegue(withIdentifier: "nearmebusiness", sender: self)
    }
    
    @IBAction func done(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SearchCategory = storyBoard.instantiateViewController(withIdentifier: "TabBarControllerBusiness") as! UITabBarController
        self.present(SearchCategory, animated: true, completion: nil)
    }
    
}

extension SearchBusinessViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchUsers.count
        } else {
            return users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if searching {
            cell?.textLabel?.text = searchUsers[indexPath.row]
        }
        else {
            cell?.textLabel?.text = users[indexPath.row]
            cell?.detailTextLabel!.text = addresses[indexPath.row]
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        GlobalVariable.currentItem = currentCell.textLabel!.text!
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SearchProfileViewController2 = storyBoard.instantiateViewController(withIdentifier: "SearchProfileViewController2")
        self.present(SearchProfileViewController2, animated: true, completion: nil)
    }
    
}

extension SearchBusinessViewController: UISearchBarDelegate {
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

