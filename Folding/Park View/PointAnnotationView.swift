//
//  myLocation.swift
//  Folding
//
//  Created by Amy Wichelow on 22/05/2016.
//  Copyright © 2016 Amy Wichelow. All rights reserved.
//

import UIKit
import MapKit

class PointAnnotationView: MKAnnotationView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
 //This file defines each annotation name and links it to the plist file. Also telling which image each pin should use.
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let pointAnnotation = self.annotation as! PointAnnotation
        switch (pointAnnotation.type) {
        case .Reception:
            image = UIImage(named: "reception")
        case .Toilets:
            image = UIImage(named: "toilets")
        case .BirdHide:
            image = UIImage(named: "birdhide")
        case .ViewPoint:
            image = UIImage(named: "viewpoint")
        case .IronAgeHut:
            image = UIImage(named: "pin")
        case .SpinalCareFacility:
            image = UIImage(named: "pin")
        case .Parking:
            image = UIImage(named: "parking")

        default:
            image = UIImage(named: "pin")
        }
    }
}