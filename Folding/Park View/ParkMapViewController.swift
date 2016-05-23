import UIKit
import MapKit
import CoreLocation





enum MapType: Int {
  case Standard = 0
  case Hybrid
  case Satellite

}


class ParkMapViewController: UIViewController {
    
    var park = Park(filename: "MagicMountain")
    
    var route: Route?
    
    var color: UIColor!
    
    @IBOutlet weak var mapView: MKMapView!
  
    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
  
    var selectedOptions = [MapOptionsType]()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let latDelta = park.overlayTopLeftCoordinate.latitude -
            park.overlayBottomRightCoordinate.latitude
        
        // think of a span as a tv size, measure from one corner to another
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        
        let region = MKCoordinateRegionMake(park.midCoordinate, span)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        mapView.region = region
        addOverlay()
        addPointPins()
        
        if route != nil {
            drawRoute()
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
        let attractions = NSArray(contentsOfFile: filePath!)
        for attraction in attractions! {
            let point = CGPointFromString(attraction["location"] as! String)
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
            let title = attraction["name"] as! String
            let typeRawValue = Int(attraction["type"] as! String)!
            let type = PointOfInterest(rawValue: typeRawValue)!
            let subtitle = attraction["subtitle"] as! String
            let annotation = PointAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
            mapView.addAnnotation(annotation)
        }
    }
    
    
    func addOverlay() {
        let overlay = ParkMapOverlay(park: park)
        mapView.addOverlay(overlay)
    }

    
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let optionsViewController = segue.destinationViewController as! MapOptionsViewController
    optionsViewController.selectedOptions = selectedOptions
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


extension ParkMapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is ParkMapOverlay {
            let magicMountainImage = UIImage(named: "maptree")
            let overlayView = ParkMapOverlayView(overlay: overlay, overlayImage: magicMountainImage!)
            
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
        let annotationView = PointAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
        annotationView.canShowCallout = true
        return annotationView
    }
    
}

extension ParkMapViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last
        
        if let newLocation = newLocation {
            print(newLocation)
        }
        
    }
    
}




