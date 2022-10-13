//
//  ViewController.swift
//  eskomThing
//
//  Created by Sthembiso Ndhlazi on 2022/10/12.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let initialLocation = CLLocation(latitude: -26.112114859606447, longitude: 28.053238876727022)
    // -26.112114859606447, 28.053238876727022
    
    //mapView.centerToLocation(initialLocation)
    

    let sourceLocation = CLLocationCoordinate2D(latitude: -26.112114859606447, longitude: 28.053238876727022)
    
    let hotelLocation = CLLocationCoordinate2D(latitude: -26.103605653039384,longitude: 28.061131207741255)
    
    let investecLocation = CLLocationCoordinate2D(latitude: -26.09846072025532,longitude: 28.056743113614175)
    
    let sandtonParkLocation = CLLocationCoordinate2D(latitude: -26.105050817992506 , longitude: 28.047001330293657)
    
    let destinationLocation = CLLocationCoordinate2D(latitude: -25.782264252379097, longitude: 28.27485353069081)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView.delegate = self
        
        //-25.782264252379097, 28.27485353069081
        
       
        
//        showRouteOnMap(pickupCoordinate: sourceLocation, destinationCoordinate: hotelLocation)
//        showRouteOnMap(pickupCoordinate: hotelLocation, destinationCoordinate: investecLocation)
//        showRouteOnMap(pickupCoordinate: investecLocation, destinationCoordinate: sandtonParkLocation)
//        showRouteOnMap(pickupCoordinate: sandtonParkLocation, destinationCoordinate: sourceLocation)
        
        
        addPins()
    }
    
    func addPins(){
        let startPin = MKPointAnnotation()
        startPin.title = "Discovery building Sandton"
        startPin.coordinate = sourceLocation
        
        let startPoint = [MKMapPoint(sourceLocation), MKMapPoint(hotelLocation), MKMapPoint(investecLocation), MKMapPoint(sandtonParkLocation)]
    
        
        let hotelPin = MKPointAnnotation()
        hotelPin.title = "Hotel"
        hotelPin.coordinate = hotelLocation
        
        let investecPin = MKPointAnnotation()
        investecPin.coordinate = investecLocation
        investecPin.title = "Investec Sandton"
        
        let sandtonParkPin = MKPointAnnotation()
        sandtonParkPin.coordinate = sandtonParkLocation
        sandtonParkPin.title = "Sandton Park"
        
        mapView.addAnnotation(hotelPin)
        mapView.addAnnotation(startPin)
        mapView.addAnnotation(investecPin)
        mapView.addAnnotation(sandtonParkPin)
        
        
        mapView.addOverlay(MKPolygon(points: startPoint, count: startPoint.count))
    }
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {

            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
            request.requestsAlternateRoutes = true
            request.transportType = .automobile

            let directions = MKDirections(request: request)

            directions.calculate { [unowned self] response, error in
                guard let unwrappedResponse = response else { return }
                
                //for getting just one route
                if let route = unwrappedResponse.routes.first {
                    //show on map
                    self.mapView.addOverlay(route.polyline)
                    //set the map area to show the route
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
                }

                //if you want to show multiple routes then you can get all routes in a loop in the following statement
                //for route in unwrappedResponse.routes {}
            }
        }
    
    //this delegate function is for displaying the route overlay and styling it
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(overlay: overlay)
         renderer.strokeColor = UIColor.green
         renderer.lineWidth = 5.0
         return renderer
    }
}



