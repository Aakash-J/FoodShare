//
//  FoodDetailTableVC.swift
//  NPF-4
//
//  Created by Aakash on 5/04/17.
//  Copyright © 2017 Aakash. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

let INFO_SECTION = 0
let IMG_SECTION = 1
let DESC_SECTION = 2
let URL_SECTION = 3
let MAP_SECTION = 4



class FoodDetailTableVC: UITableViewController {
    
    var name: String!
    var dataSource : [[String]]!
    var longi : Double!
    var latit : Double!

    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

 
    override func numberOfSections(in tableView: UITableView) -> Int {

        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(longi)
        print(latit)
        return dataSource[section].count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")

        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell?.textLabel?.text = dataSource[indexPath.section][indexPath.row]
            cell?.textLabel?.textAlignment = .center
            cell?.backgroundColor = UIColor(red:0.51, green:0.04, blue:0.73, alpha:1.0)
            cell?.textLabel?.textColor = UIColor.white
        
        return cell!
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        _ = tableView.cellForRow(at: indexPath)! as UITableViewCell
        print(indexPath.section)
        switch indexPath.section {
          case 4:
            openMapForPlace() 
          //  let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "mapvcId") as! MapVC
           // let secondVC = MapVC(style: .grouped)
           // let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "mapviewId") as! MapVC
          //  navigationController?.pushViewController(secondVC, animated: true)         //   self.navigationController?.pushViewController(secondViewController, animated: true)
            
         // zoomDelegate?.zoomOnAnnotation(loc!)
        default:
            break
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                  return 44
    
    }

    func openMapForPlace() {
        
        let latitude: CLLocationDegrees = latit
        let longitude: CLLocationDegrees = longi
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Food Location"
        mapItem.openInMaps(launchOptions: options)
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

}
