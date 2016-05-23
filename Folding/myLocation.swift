//
//  myLocation.swift
//  Folding
//
//  Created by Hallam John Ager on 23/05/2016.
//  Copyright © 2016 Kyle Goslan. All rights reserved.
//

import Foundation
import CoreLocation


class myLocation {
    
    var coord: CLLocationCoordinate2D!
    var identifier: String!
    var regionDistance: Double!
    
    var region: CLCircularRegion {
        return CLCircularRegion(center: coord, radius: 200, identifier: identifier)
    
    }
    
    init(coord: CLLocationCoordinate2D, identifier: String){
        self.coord = coord
        self.identifier = identifier
    
    }


}