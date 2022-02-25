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
    @IBOutlet var searchview: UISearchBar!
    
    var filterdata:[String]!
    
    let apiSat: ApiSat = ApiSat()
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.mapView.mapType = MKMapType.hybridFlyover
        self.apiSat.getAllSatellitesName()
        self.timer = Timer.scheduledTimer(withTimeInterval: 7, repeats: true, block: { _ in
            self.getByName(name: "HST")
        })
        
        
    }
    
    func getByName(name: String) -> () {
        let urlSearch = URL(string: apiSat.url + "?search=" + name)
        //var resultsReq2: [String: AnyObject] = [:]
        self.apiSat.getSatelites(url: urlSearch!) {results in
            print(self.mapView.annotations);
            DispatchQueue.main.async {
                let allAnnotations = self.mapView.annotations
                self.mapView.removeAnnotations(allAnnotations)
             }
            for item in results! {
                let id = item["satelliteId"]!
                let urlSearch = URL(string: self.apiSat.url + "/" + String(describing: id) + "/propagate")!
                self.apiSat.getSateliteData(url: urlSearch) { results in
                    var sat = self.apiSat.createSat(data: results)
                    //self.mapView.remove
                    self.mapView.addAnnotation(sat)
                    print("satellite ajouté")
                }
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





class SatellitesSingleton {
    
    public static let sharedInstance = SatellitesSingleton()
    
    public var satelliteList = [Satellite]() {
        willSet(newSat) {
            print(newSat)
            print("on entre dans le willset")
            addSatellite(satellite: newSat)
        }
        didSet {
            print(satelliteList)
            print("on entre dans le didset")
        }
    }
    
    public var satelliteListName = [String](){
        willSet(newSat) {
            print("theo")
            print(newSat)
        }
    }
    
    

    private init() {}

    
    func addSatellite(satellite: [Satellite]) {
        print("c'estv la")
        print(satellite[0])
        DispatchQueue.main.async {
            let viewController: ViewController = ViewController()
            let mapView = viewController.mapView
            mapView?.addAnnotation(satellite[0])
        }
    }
    
}
