//comment

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

//work by Olly

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