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
        
        let region = MKCoordinateRegionMake(holton.midCoordinate, span)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        mapView.setUserTrackingMode(.Follow, animated: true)

        
        mapView.region = region
        addOverlay()
        addPointPins()
        
        if route != nil {
            drawRoute()
        }
        
        let birdHide = myLocation(coord: CLLocationCoordinate2D(latitude: 50.723313, longitude: -2.053055), identifier: "birdHide")
        locationsArray.append(birdHide)
        
        let deadTree = myLocation(coord: CLLocationCoordinate2D(latitude: 50.722241, longitude: -2.050978),  identifier: "deadTree")
        locationsArray.append(deadTree)
        
        let stuckInARut = myLocation(coord: CLLocationCoordinate2D(latitude: 50.720192, longitude: -2.058198),  identifier: "stuckInARut")
        locationsArray.append(stuckInARut)
        
        let ironAgeHut = myLocation(coord: CLLocationCoordinate2D(latitude: 50.724758, longitude: -2.057954),  identifier: "ironAgeHut")
        locationsArray.append(ironAgeHut)
        
        let freeBirdSculpture = myLocation(coord: CLLocationCoordinate2D(latitude: 50.724247, longitude: -2.056046),  identifier: "freeBirdSculpture")
        locationsArray.append(freeBirdSculpture)
        
        let reception = myLocation(coord: CLLocationCoordinate2D(latitude: 50.72118, longitude: -2.056483),  identifier: "reception")
        locationsArray.append(reception)
        
        let potteryPavilion = myLocation(coord: CLLocationCoordinate2D(latitude: 50.720601, longitude: -2.057801),  identifier: "potteryPavilion")
        locationsArray.append(potteryPavilion)
        
        let sensoryGarden = myLocation(coord: CLLocationCoordinate2D(latitude: 50.722221, longitude: -2.054502),  identifier: "sensoryGarden")
        locationsArray.append(sensoryGarden)
        
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

    
  
  @IBAction func mapTypeChanged(sender: AnyObject) {
    let mapType = MapType(rawValue: mapTypeSegmentedControl.selectedSegmentIndex)
    switch (mapType!) {
    case .Standard:
        mapView.mapType = MKMapType.Standard
    case .Hybrid:
        mapView.mapType = MKMapType.Hybrid
    case .Satellite:
        mapView.mapType = MKMapType.Satellite
    }
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
            
        }
        
        func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion){
            print(region.identifier)
            birdHideImg.image = UIImage(named:"Bird Hide Path")
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion){
        birdHideImg.image = nil
    }
    
}




