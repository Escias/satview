//
//  ViewController.swift
//  SatView
//
//  Created by Jimmy Lai on 23/02/2022.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttonImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.mapType = MKMapType.hybridFlyover
                
                /*let satellite = Satellite(
                  id: "20580",
                  name: "HST",
                  altitude: "535.6591127323209",
                  coordinate: CLLocationCoordinate2D(latitude: 25.402713599913692, longitude: 5.180406219949209))
                mapView.addAnnotation(satellite)*/
        
        
        /*ApiSat.apiSat.requestWithUrl(url: url!) {results in
            //print(results)
            for item in results! {
                sate = ApiSat.sat.init(name: item["name"] as! String, latitude: item["line1"] as! String, longitude: item["line2"] as! String, id: item["satelliteId"] as! Int)
                print("nous sommes dedans")
                print(sate)
            }
        }*/
        let data = ApiSat.apiSat.getByName(name: "HST")
        print(data)
        
    }
    
    @IBAction func buttonImage(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Table") as? ImageCollection {
            self.navigationController?.pushViewController(vc, animated: true)
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
