//
//  CalanderCustomerViewController.swift
//  Glam
//
//  Created by Student on 11/13/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit
import FSCalendar
class CalanderCustomerViewController: UIViewController, FSCalendarDelegate {
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
    }
    
    @IBAction func done(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SearchCategory = storyBoard.instantiateViewController(withIdentifier: "SearchProfileViewController3")
        self.present(SearchCategory, animated: true, completion: nil)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let select = date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let string = formatter.string(from: select)
        let alert = UIAlertController(title: "Date Selected", message: string, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss", style: .cancel))
        self.present(alert,animated: true, completion: nil)
    }

}
