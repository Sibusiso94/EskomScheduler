//
//  ViewController.swift
//  EskomSchedule
//
//  Created by Sibusiso Mbonani on 2022/10/11.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    let dp = DataProvider()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        builder()
        
        let initialLocation = CLLocation(latitude: -26.112114859606447, longitude: 28.053238876727022)
       // -26.112114859606447, 28.053238876727022
        
        mapView.centerToLocation(initialLocation)
        
        
        // 1.
                mapView.delegate = self
                
                // 2.
                let sourceLocation = CLLocationCoordinate2D(latitude: -26.112114859606447, longitude: 28.053238876727022)
                let destinationLocation = CLLocationCoordinate2D(latitude: -25.782264252379097, longitude: 28.27485353069081)
        
        //-25.782264252379097, 28.27485353069081
                // 3.
                let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
                let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
                
                // 4.
                let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
                let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
                
                // 5.
                let sourceAnnotation = MKPointAnnotation()
                sourceAnnotation.title = "Times Square"
                
                if let location = sourcePlacemark.location {
                    sourceAnnotation.coordinate = location.coordinate
                }
                
                
                let destinationAnnotation = MKPointAnnotation()
                destinationAnnotation.title = "Menlyn mall"
                
                if let location = destinationPlacemark.location {
                    destinationAnnotation.coordinate = location.coordinate
                }
                
                // 6.
                self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
                
                // 7.
                let directionRequest = MKDirections.Request()
                directionRequest.source = sourceMapItem
                directionRequest.destination = destinationMapItem
                directionRequest.transportType = .automobile
                
                // Calculate the direction
                let directions = MKDirections(request: directionRequest)
                
                // 8.
        directions.calculate {
                    (response, error) -> Void in
                    
                    guard let response = response else {
                        if let error = error {
                            print("Error: \(error)")
                        }
                        
                        return
                    }
                    
                    let route = response.routes[0]
                    self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
                    
                    let rect = route.polyline.boundingMapRect
                    self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                }
    
    }

    func builder() {

        if let localData = dp.readLocalFile(forName: "data") {
            dp.parse(jsonData: localData)
        }
        let dateTime = Date()

//        print(dateTime)
    }
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .green
            renderer.lineWidth = 4.0
        
            return renderer
        }


}



private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
