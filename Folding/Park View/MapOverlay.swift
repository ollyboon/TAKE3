import UIKit
import MapKit

class MapOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    init(holton: Holton) {
        boundingMapRect = holton.overlayBoundingMapRect
        coordinate = holton.midCoordinate
    }
}