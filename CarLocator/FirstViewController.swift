//
//  FirstViewController.swift
//  CarLocator
//
//  Created by DNA on 04/07/2016.
//  Copyright © 2016 jojo. All rights reserved.
//

import UIKit
import CoreLocation
class FirstViewController: UITableViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //location trigger
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        switch(CLLocationManager.authorizationStatus()) {
            
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.startUpdatingLocation()
        case .Denied:
            let alert = UIAlertController(title: "Permissions error", message: "This app needs location permission to work accurately", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
            
        case .NotDetermined:
            fallthrough
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationCell", forIndexPath: indexPath)
        cell.tag = indexPath.row
        //configure cell
        let entry: CLLocation = DataManager.sharedInstance.locations[indexPath.row]
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss, MM-dd-yyy"
        
        cell.textLabel?.text = "\(entry.coordinate.latitude), \(entry.coordinate.longitude)"
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(entry.timestamp)
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.locations.count
    }

    
    @IBAction func addLocation(sender: UIBarButtonItem) {
        var location: CLLocation
        
        if(CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse) {
            location = CLLocation(latitude: 32.830579, longitude: -117.153839)
        }
        else {
            location = locationManager.location!
        }
        
        DataManager.sharedInstance.locations.insert(location, atIndex: 0)
        
        tableView.reloadData()
    }

}

