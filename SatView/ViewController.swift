//
//  ViewController.swift
//  SatView
//
//  Created by Jimmy Lai on 23/02/2022.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.mapType = .hybridFlyover
        
        let satellite = Satellite(
          id: "20580",
          name: "HST",
          altitude: "535.6591127323209",
          coordinate: CLLocationCoordinate2D(latitude: 25.402713599913692, longitude: 5.180406219949209))
        mapView.addAnnotation(satellite)
        
        // Do any additional setup after loading the view.
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
