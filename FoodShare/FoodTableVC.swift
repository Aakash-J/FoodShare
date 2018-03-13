//
//  FoodTableVC.swift
//  NPF-4
//
//  Created by Aakash on 5/04/17.
//  Copyright © 2017 Aakash. All rights reserved.
//

import UIKit
import CoreLocation




class FoodTableVC: UITableViewController{
    
    var countData : Int = 0
    var names = [String]()
    var quantity = [String]()
    var details = [String]()
    var locations = [String]()
    var longi = [Double]()
    var latit = [Double]()
    
    
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                
    }

    override func viewWillAppear(_ animated: Bool) {
       
       names.removeAll()
        self.tableView.reloadData()
        updateIP()
        self.tableView.reloadData()
        
        
     
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(names.count)
        
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath)
      
        let name = names[indexPath.row]
      //  let distance = mapVC?.locationManager?.location?.distance(from: Food.getLocation())
        
        cell.textLabel?.text = name;
        cell.textLabel?.textColor = UIColor.white
     //   cell.detailTextLabel?.text = "Distance: " + convertStringMetersToMiles((distance?.description)!) + " miles"
     //   cell.accessoryType = .disclosureIndicator
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func convertStringMetersToMiles(_ distance:String) -> String {
        let meterDistance = Double(distance)
        let milesDistance = round(meterDistance! * 0.00062137)
        print(milesDistance)
        return String(milesDistance)
    }
    
   
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
            let name = self.names[indexPath.row]
            let ds: [[String]] = [[self.names[indexPath.row]],[self.quantity[indexPath.row]],[self.details[indexPath.row]],[locations[indexPath.row]],["Show On Map"]]
            let detailVC = FoodDetailTableVC(style: .grouped)
            detailVC.title = "Food Information"
            detailVC.name = name
            detailVC.dataSource = ds
        detailVC.longi = longi[indexPath.row];
        detailVC.latit = latit[indexPath.row];
        
        
          //  detailVC.loc = myLocation
        
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
     //    detailVC.zoomDelegate = mapVC
        
        
  

   
   
  /*  @IBAction func sort(_ sender: Any) {
        switch ((sender as AnyObject).selectedSegmentIndex) {
        case 0:
            Foods.sort(by: {$0.getFoodName() < $1.getFoodName()})
            self.tableView.reloadData()
        case 1:
            Foods.sort(by: {$0.getFoodName() > $1.getFoodName()})
            self.tableView.reloadData()
        default:
            Foods.sort(by: {convertStringMetersToMiles((mapVC?.locationManager?.location?.distance(from: $0.getLocation()).description)!) < convertStringMetersToMiles((mapVC?.locationManager?.location?.distance(from: $1.getLocation()).description)!)})
            self.tableView.reloadData()

        }

    } */
    
    //MARK: - REST calls
    // This makes the GET call 
    func updateIP() {
        
        let endpoint = URL(string: "https://people.rit.edu/aj9306/data.json")
        
        //should be put in d0-catch block
        let data =  try? Data(contentsOf: endpoint!)
        
        //validate and deserialize the response
        do {
            if let data = data,
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                let blogs = json["Data"] as? [[String: Any]] {
                for blog in blogs {
                    if let location = blog["Location"] as? String {
                        
                        let loc = location
                        
                        let regex = try! NSRegularExpression(pattern:"<(.*?)>", options: [])
                        var results = [String]()
                        let tmp = loc as NSString
                        regex.enumerateMatches(in: loc, options: [], range: NSMakeRange(0, loc.characters.count)) { result, flags, stop in
                            if let range = result?.rangeAt(1) {
                                results.append(tmp.substring(with: range))
                            }
                        }
                        var coordiantes = results[0].components(separatedBy: ",")
                        let lati: Double = (NumberFormatter().number(from: coordiantes[0])?.doubleValue)!
                        let long: Double = (NumberFormatter().number(from: coordiantes[1])?.doubleValue)!
                        print(lati)
                        print(long)
                        let myLocation = CLLocation(latitude: lati, longitude: long)
                        let distance = (myLocation.distance(from: Slider.location).description)
                        let dist = ((convertStringMetersToMiles(distance)) as NSString).integerValue
                        
                        if (dist > Slider.Slidernumber) {
                        continue
                        }
                        longi.append(long)
                        latit.append(lati)
                        var address:String = ""
                        let geocoder = CLGeocoder()
                        print(myLocation)
                        geocoder.reverseGeocodeLocation(myLocation) { (placemarksArray, error) in
                            
                            if (placemarksArray?.count)! > 0 {
                                
                                let placemark = placemarksArray?.first
                                let number = placemark!.subThoroughfare
                                let bairro = placemark!.subLocality
                                let street = placemark!.thoroughfare
                                let locality =  placemark!.locality
                                address = "Address: \(street!), \(number!) - \(bairro!), \(locality!)"
                            }
                            
                            self.locations.append(address)
                            print(address)
                        }
                    }
                    
                    if let name = blog["FoodName"] as? String {
                        self.names.append(name)
                    }
                    if let quant = blog["FoodQuantity"] as? String {
                        self.quantity.append(quant)
                    }
                    if let detail = blog["Details"] as? String {
                        self.details.append(detail)
                    }
                    }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        print(names)
         print(quantity)
         print(details)
         print(locations)
}
    
            
}
