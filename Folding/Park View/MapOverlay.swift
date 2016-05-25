//
//  myLocation.swift
//  Folding
//
//  Created by Olly Boon on 10/05/2016.
//  Copyright © 2016 Olly Boon. All rights reserved.
//

import UIKit
import MapKit

//This file defines names for the bourndary and mid coordinate of the overlay to be used in other files.

class MapOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    init(holton: Holton) {
        boundingMapRect = holton.overlayBoundingMapRect
        coordinate = holton.midCoordinate
    }
}