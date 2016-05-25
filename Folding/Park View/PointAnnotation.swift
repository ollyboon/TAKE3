//
//  myLocation.swift
//  Folding
//
//  Created by Amy Wichelow on 22/05/2016.
//  Copyright © 2016 Amy Wichelow. All rights reserved.
//

import UIKit
import MapKit

enum PointOfInterest: Int {
    case Default = 0
    case Reception
    case Toilets
    case BirdHide
    case ViewPoint
    case IronAgeHut
    case SpinalCareFacility
    case Parking
}

//Defines points of interest and creates initialiser for the pointAnnotation object

class PointAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: PointOfInterest
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, type: PointOfInterest) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}