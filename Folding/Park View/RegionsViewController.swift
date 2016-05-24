//
//  Regions.swift
//  Folding
//
//  Created by Olly  on 24/05/2016.
//  Copyright © 2016 Kyle Goslan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RegionsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.setUserTrackingMode(.Follow, animated: true)
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: 50.723313, longitude: -2.053055)
        let region = CLCircularRegion(center: location, radius: 200, identifier: "birdHide")
        locationManager.startMonitoringForRegion(region)
    }
}

extension RegionsViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print(region.identifier)
    }
    
}
