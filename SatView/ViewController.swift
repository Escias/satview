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
        self.mapView.mapType = MKMapType.hybrid

        var satellite: ApiSat.sat! = nil
        let url = URL(string: "https://tle.ivanstanojevic.me/api/tle?search=HST")
        ApiSat.apiSat.requestWithUrl(url: url!) {results in
            //print(results)
            for item in results! {
                satellite = ApiSat.sat.init(name: item["name"] as! String, latitude: item["line1"] as! String, longitude: item["line2"] as! String, id: item["satelliteId"] as! Int)
                print("nous sommes dedans")
                print(satellite)
            }
        }
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
