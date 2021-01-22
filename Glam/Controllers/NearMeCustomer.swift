import UIKit
import MapKit
import CoreLocation
import Parse

class NearMeCustomer: UITableViewController {
    var users: [String] = []
    var address: [String] = []
    
    let locationManager = CLLocationManager()
    var currentLat = 0.0
    var currentLong = 0.0
    
    struct GlobalVariable {
        static var currentItem = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    }
    
    @IBAction func done(_ sender: Any) {
        performSegue(withIdentifier: "backToSearch", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        let query = PFUser.query()
        query?.whereKey("type", equalTo: "business")
        do {
            let results: [PFObject] = try (query?.findObjects())!
            for name in results {
                let geocoder = CLGeocoder()
                geocoder.geocodeAddressString(name["address"] as! String) { (placemark, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    else {
                        if let location = placemark?.first?.location {
                            let lat = location.coordinate.latitude
                            let long = location.coordinate.longitude
                            print("current")
                            print(self.currentLat)
                            print(self.currentLong)
                            print("location")
                            print(lat)
                            print(long)
                            if abs(self.currentLat) - 2.0 <= abs(lat) && abs(self.currentLat) + 2.0 >= abs(lat) && abs(self.currentLong) - 2.0 <= abs(long) && abs(self.currentLong) + 2.0 >= abs(long)  {
                                self.users.append(name["username"] as! String)
                                self.address.append(name["address"] as! String)
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
                
            }
            
        }
        catch {
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customernearmecell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row]
        cell.detailTextLabel?.text = address[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        GlobalVariable.currentItem = currentCell.textLabel!.text!
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SearchProfileViewController = storyBoard.instantiateViewController(withIdentifier: "SearchProfileViewController5")
        self.present(SearchProfileViewController, animated: true, completion: nil)
    }
    
}

extension NearMeCustomer: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLong = location.coordinate.longitude
            currentLat = location.coordinate.latitude
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


