import UIKit
import MapKit

class PointAnnotationView: MKAnnotationView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let pointAnnotation = self.annotation as! PointAnnotation
        switch (pointAnnotation.type) {
        case .Reception:
            image = UIImage(named: "pin")
        case .Toilets:
            image = UIImage(named: "pin")
        case .BirdHide:
            image = UIImage(named: "pin")
        case .ViewPoint:
            image = UIImage(named: "pin")
        case .IronAgeHut:
            image = UIImage(named: "pin")
        case .SpinalCareFacility:
            image = UIImage(named: "pin")
        case .Parking:
            image = UIImage(named: "pin")

        default:
            image = UIImage(named: "")
        }
    }
}