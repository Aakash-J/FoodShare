//
//  MainViewController.swift
//  FoodShare
//
//  Created by Aakash on 5/9/17.
//  Copyright © 2017 Aakash. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {

   
    @IBOutlet weak var miles: UILabel!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var SearchButton: UIButton!
    
    var locationManager = CLLocationManager()
    
    var userLocation:CLLocation!

    
    @IBAction func milesSlider(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
        Slider.Slidernumber =  Int(sender.value)
        
        miles.text = "\(currentValue)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        donateButton.backgroundColor = .clear
        donateButton.layer.cornerRadius = 5
        donateButton.layer.borderWidth = 3
        donateButton.layer.borderColor = UIColor.white.cgColor
        
        SearchButton.backgroundColor = .clear
        SearchButton.layer.cornerRadius = 5
        SearchButton.layer.borderWidth = 3
        SearchButton.layer.borderColor = UIColor.white.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
