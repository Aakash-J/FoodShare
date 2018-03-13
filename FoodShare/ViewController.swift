//
//  ViewController.swift
//  FoodShare
//
//  Created by Aakash on 5/5/17.
//  Copyright © 2017 Aakash. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate  {

    @IBOutlet weak var FoodName: UITextField!
    @IBOutlet weak var FoodQuan: UITextField!
    @IBOutlet weak var FoodDetails: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    var locationManager = CLLocationManager()
    
    var userLocation:CLLocation!

    
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        
       
        print(Slider.Slidernumber)
        
    

           }
    
    @IBAction func submit(_ sender: Any) {
     
        if(FoodName.text == "") {
            let alert = UIAlertController(title: "Alert", message: "Please Enter Food Name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
        postDataToURL();
        
        FoodName.text = ""
        FoodQuan.text = ""
        FoodDetails.text = ""
        
        let alert = UIAlertController(title: "Alert", message: "Successful", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
        
    }
    
        func postDataToURL() {
            
            let myUrl = URL(string: "https://people.rit.edu/aj9306/API.php");
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "POST"// Compose a query string
            let jsonString =
            "{'FoodName':'FoodName: \(FoodName.text!)', 'FoodQuantity':'FoodQuantity: \(FoodQuan.text!)','Details':'Details: \(FoodDetails.text!)','Location':'Location: \(userLocation!)'}";
             print(jsonString)
            let postString = "Data=\(jsonString)&op=w";
            request.httpBody = postString.data(using: String.Encoding.utf8);
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil
                {
                    print("error=\(error)")
                    return
                }
                // You can print out response object
                print("response = \(response)")
                //Let's convert response sent from a server side script to a NSDictionary object:
            }
            task.resume()
            
        }
        
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)
    {
        locationManager.stopUpdatingLocation()
        if ((error) != nil)
        {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
                
        determineMyCurrentLocation()
    }
    
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        //
        
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        Slider.location = userLocation
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
}

