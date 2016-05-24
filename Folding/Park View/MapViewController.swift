import UIKit
import MapKit
import CoreLocation


enum MapType: Int {
  case Standard = 0
  case Hybrid
  case Satellite

}


class MapViewController: UIViewController {
    
    var holton = Holton(filename: "HoltonLee")
    
    var route: Route?
    
    var color: UIColor!
    
    @IBOutlet weak var birdHideImg: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
  
    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
    
    let locationManager = CLLocationManager()
    var locationsArray = [myLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let latDelta = holton.overlayTopLeftCoordinate.latitude -
            holton.overlayBottomRightCoordinate.latitude
        
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        
        let mapregion = MKCoordinateRegionMake(holton.midCoordinate, span)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()

        mapView.setUserTrackingMode(.Follow, animated: true)
        mapView.region = mapregion
        
        addOverlay()
        addPointPins()
        
        if route != nil {
            drawRoute()
        }
        
        
        
        let birdHideRegion = myLocation(coord: CLLocationCoordinate2D(latitude: 50.723313, longitude: -2.053055), identifier: "birdHideRegion")
        locationsArray.append(birdHideRegion)
        
        let deadTreeRegion = myLocation(coord: CLLocationCoordinate2D(latitude: 50.722241, longitude: -2.050978),  identifier: "deadTreeRegion")
        locationsArray.append(deadTreeRegion)
        
        let stuckInARutRegion = myLocation(coord: CLLocationCoordinate2D(latitude: 50.720192, longitude: -2.058198),  identifier: "stuckInARutRegion")
        locationsArray.append(stuckInARutRegion)
        
        let ironAgeHutRegion = myLocation(coord: CLLocationCoordinate2D(latitude: 50.724758, longitude: -2.057954),  identifier: "ironAgeHutRegion")
        locationsArray.append(ironAgeHutRegion)
        
        let freeBirdSculptureRegion = myLocation(coord: CLLocationCoordinate2D(latitude: 50.724247, longitude: -2.056046),  identifier: "freeBirdSculptureRegion")
        locationsArray.append(freeBirdSculptureRegion)
        
        let receptionRegion = myLocation(coord: CLLocationCoordinate2D(latitude: 50.72118, longitude: -2.056483),  identifier: "receptionRegion")
        locationsArray.append(receptionRegion)
        
        let potteryPavilionRegion = myLocation(coord: CLLocationCoordinate2D(latitude: 50.720601, longitude: -2.057801),  identifier: "potteryPavilionRegion")
        locationsArray.append(potteryPavilionRegion)
        
        let sensoryGardenRegion = myLocation(coord: CLLocationCoordinate2D(latitude: 50.722221, longitude: -2.054502),  identifier: "sensoryGardenRegion")
        locationsArray.append(sensoryGardenRegion)
        

        for location in locationsArray {
        locationManager.startMonitoringForRegion(location.region)
        }
        
        
    }
    
    func drawRoute() {
        print(route?.name)
        let thePath = NSBundle.mainBundle().pathForResource(route!.name, ofType: "plist")
        let pointsArray = NSArray(contentsOfFile: thePath!)
        
        let pointsCount = pointsArray!.count
        
        var pointsToUse: [CLLocationCoordinate2D] = []
        
        for i in 0...pointsCount-1 {
            let p = CGPointFromString(pointsArray![i] as! String)
            pointsToUse += [CLLocationCoordinate2DMake(CLLocationDegrees(p.x), CLLocationDegrees(p.y))]
        }
        
        let myPolyline = MKPolyline(coordinates: &pointsToUse, count: pointsCount)
        
        mapView.addOverlay(myPolyline)
    }

    
    func addPointPins() {
        let filePath = NSBundle.mainBundle().pathForResource("PointsOfInterest", ofType: "plist")
        let interests = NSArray(contentsOfFile: filePath!)
        for interest in interests! {
            let point = CGPointFromString(interest["location"] as! String)
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
            let title = interest["name"] as! String
            let typeRawValue = Int(interest["type"] as! String)!
            let type = PointOfInterest(rawValue: typeRawValue)!
            let subtitle = interest["subtitle"] as! String
            let annotation = PointAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
            mapView.addAnnotation(annotation)
        }
    }
    
    
    func addOverlay() {
        let overlay = MapOverlay(holton: holton)
        mapView.addOverlay(overlay)
    }

}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MapOverlay {
            let holtonLeeImage = UIImage(named: "maptree")
            let overlayView = MapOverlayView(overlay: overlay, overlayImage: holtonLeeImage!)
            
            return overlayView
        } else if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = route!.color
            lineView.lineWidth = 11.0
            
            return lineView
        } else if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.magentaColor()
            
            return polygonView
        }
        return MKOverlayRenderer()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if !annotation.isKindOfClass(MKUserLocation) {
            let annotationView = PointAnnotationView(annotation: annotation, reuseIdentifier: "Interest")
            annotationView.canShowCallout = true
            return annotationView
        }
        return nil
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        if let newLocation = newLocation {
          print(newLocation)
        }
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion){
        print(region.identifier)
        birdHideImg.image = UIImage(named: region.identifier)
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion){
//        birdHideImg.image = nil
        
        
    }
    
}




