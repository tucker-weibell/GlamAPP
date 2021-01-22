import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navTitle: UINavigationItem!
    var senders = [String]()
    var message = [String]()
    var state = [String]()
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var dataStringSender = ""
    var dataStringReciever = ""
    var senderName = ""
    var color = UIColor(displayP3Red: 12/255, green: 116/255, blue: 255/255, alpha: 1)
    let device = UIDevice.current
    var dictionary = [String:String]()
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toSettings(_ sender: Any) {
        performSegue(withIdentifier: "toChatSettings", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tableView.reloadData()
        let indexPath = NSIndexPath(item: (message.count-1), section: 0)
        if message.count != 0 {
            tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }
        navTitle.title = MessageCustomerViewController.GlobalVars.selectedItem
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func getData() {
        let user = PFUser.current()
        let username = user?.username
        senderName = username!
        let query = PFQuery(className: "Messages")
        query.whereKey("username", equalTo: username!)
        do {
            let result = try query.findObjects()
            if result[0]["Messages"] != nil {
                let file = result[0]["Messages"] as! PFFileObject
                do {
                    let data = try file.getData()
                    let string = String(decoding: data, as: UTF8.self)
                    dataStringSender = string
                    let cvsRows = string.components(separatedBy: "!NEWLINE!")
                    for row in cvsRows {
                        var itemsRow = row.components(separatedBy: "!SEPERATE!")
                        if itemsRow[0] == MessageCustomerViewController.GlobalVars.selectedItem {
                            senders.append(itemsRow[0])
                            message.append(itemsRow[1])
                            state.append(itemsRow[2])
                        }
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
        let newQuery = PFUser.query()
        newQuery?.whereKey("username", equalTo: username!)
        do {
            let result = try newQuery?.findObjects()
            if result![0]["chatColor"] != nil {
                let colorFile = result![0]["chatColor"] as! PFFileObject
                do {
                    let data = try colorFile.getData()
                    let colorString = String(decoding: data, as: UTF8.self)
                    let cvsRows = colorString.components(separatedBy: "!NEWLINE!")
                    print(cvsRows)
                    for row in cvsRows {
                        print(row)
                        var itemsRow = row.components(separatedBy: "!SEPERATE!")
                        dictionary[itemsRow[0]] = itemsRow[1]
                    }
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
        if dictionary[MessageCustomerViewController.GlobalVars.selectedItem] != nil {
            print("dictionary: \(dictionary)")
            let currentColor = dictionary[MessageCustomerViewController.GlobalVars.selectedItem]
            switch(currentColor) {
            case "red":
                color = UIColor(displayP3Red: 226/255, green: 117/255, blue: 115/255, alpha: 1)
            case "orange":
                color = UIColor(displayP3Red: 255/255, green: 281/255, blue: 116/255, alpha: 1)
            case "yellow":
                color = UIColor(displayP3Red: 255/255, green: 223/255, blue: 106/255, alpha: 1)
            case "green":
                color = UIColor(displayP3Red: 212/255, green: 255/255, blue: 133/255, alpha: 1)
            case "teal":
                color = UIColor(displayP3Red: 163/255, green: 255/255, blue: 182/255, alpha: 1)
            case "skyBlue":
                color = UIColor(displayP3Red: 176/255, green: 255/255, blue: 237/255, alpha: 1)
            case "chalkBlue":
                color = UIColor(displayP3Red: 126/255, green: 223/255, blue: 255/255, alpha: 1)
            case "purple":
                color = UIColor(displayP3Red: 170/255, green: 184/255, blue: 255/255, alpha: 1)
            case "pink":
                color = UIColor(displayP3Red: 249/255, green: 188/255, blue: 255/255, alpha: 1)
            default:
                break
            }
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        
        let query = PFUser.query()
        query?.whereKey("username", equalTo: MessageCustomerViewController.GlobalVars.selectedItem)
        do {
            let result = try query?.findObjects()
            if result?[0]["Messages"] != nil {
                let file = result![0]["Messages"] as! PFFileObject
                do {
                    let data = try file.getData()
                    let string = String(decoding: data, as: UTF8.self)
                    dataStringReciever = string
                }
                catch {
                    print(error)
                }
            }
        }
        catch {
            print(error)
        }
        
        if dataStringSender == "" {
            dataStringSender = dataStringSender + MessageCustomerViewController.GlobalVars.selectedItem + "!SEPERATE!" + textView.text + "!SEPERATE!" + "Sent"
        } else {
            dataStringSender = dataStringSender + "!NEWLINE!" + MessageCustomerViewController.GlobalVars.selectedItem + "!SEPERATE!" + textView.text + "!SEPERATE!" + "Sent"
        }
        if dataStringReciever == "" {
            dataStringReciever = dataStringReciever + senderName + "!SEPERATE!" + textView.text + "!SEPERATE!" + "Recieved"
        } else {
             dataStringReciever = dataStringReciever + "!NEWLINE!" + senderName + "!SEPERATE!" + textView.text + "!SEPERATE!" + "Recieved"
        }

        
        //Convert strings to data and data to files
        let dataSent = Data(dataStringSender.utf8)
        let dataRecieved = Data(dataStringReciever.utf8)
        let fileSent = PFFileObject(name: "message.txt", data: dataSent)
        let fileRecieved = PFFileObject(name: "message.txt", data: dataRecieved)
        
        //save fileSent to current user
        let user = PFUser.current()
        let theUsername = user?.username
        let myQuery = PFQuery(className: "Messages")
        myQuery.whereKey("username", equalTo: theUsername!)
        do {
            let myUser = try myQuery.findObjects()
            myUser[0]["Messages"] = fileSent
            do {
                try myUser[0].save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
        
        //save fileRecieved to "other user"
        let newQuery = PFQuery(className: "Messages")
        newQuery.whereKey("username", equalTo: MessageCustomerViewController.GlobalVars.selectedItem)
        do {
            let object = try newQuery.findObjects()
            object[0]["Messages"] = fileRecieved
            do {
                try object[0].save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
        
        textView.text = ""
        clearData()
        viewDidLoad()
        
    }
    
    func clearData() {
        message.removeAll()
        state.removeAll()
        senders.removeAll()
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            var height = keyboardRectangle.height
            height = height * -1
            if device.name == "iPhone XR" {
                bottomConstraint.constant = height + 35
            }
            else {
                bottomConstraint.constant = height
            }
        }
        
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        bottomConstraint.constant = 0
        textView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if state[indexPath.row] == "Sent" {
           let mycell = tableView.dequeueReusableCell(withIdentifier: "messagescellbaby") as! MessagesCell
            mycell.sentText.text = message[indexPath.row]
            mycell.recievedView.backgroundColor = color
            cell = mycell
        }
        else {
            let mycell = tableView.dequeueReusableCell(withIdentifier: "messagescellbaby2") as! MessagesCell2
            mycell.revievedLabel.text = message[indexPath.row]
            cell = mycell
        }
        return cell
    }
}
