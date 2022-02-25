//
//  ApiSat.swift
//  SatView
//
//  Created by administration4 on 23/02/2022.
//

import UIKit
import MapKit

class ApiSat {
    
    let url = "https://tle.ivanstanojevic.me/api/tle"
    
    public static let apiSat = ApiSat()
    
    
    init() {}
    
    public func createSat(data: [String: AnyObject]) -> (Satellite) {
        let coordinates = CLLocationCoordinate2D(latitude: data["geodetic"]!["latitude"] as! Double, longitude: data["geodetic"]!["longitude"] as! Double - 180)
        let id = data["tle"]!["satelliteId"] as! Int
        let name = data["tle"]!["name"] as! String
        let altitude = data["geodetic"]!["altitude"] as! Double
        let satellite = Satellite(id: id, name: name, altitude: altitude, coordinate: coordinates)
        return satellite
    }
    
    public func getSatelites(url: URL, completion: @escaping ([[String: AnyObject]]?) -> () ) {
        let satInfos: [[String: AnyObject]]? = nil
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                completion(nil)
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                        if let satInfos = data["member"] as? [[String: AnyObject]] {
                            completion(satInfos)
                        }
                    }
                } else {
                    completion(satInfos)
                }
            }
        }
        task.resume()
    }
    
    
    public func getSateliteData(url: URL, completion: @escaping ([String: AnyObject]) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                        if let satInfos = data["geodetic"] as? [String: AnyObject] {
                            completion(data)
                        }
                    }
                }
            }
        }

        task.resume()
    }
    

                        
    
    public func getAllSatellitesName() {
        var satName: [String] = [String]()
        let task = URLSession.shared.dataTask(with: URL(string: self.url)!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                        if let satInfos = data["member"] as? [[String: AnyObject]] {
                            for dataSatelite in satInfos {
                                let name = dataSatelite["name"]!
                                satName.append(name as! String)
                            }
                            SatellitesSingleton.sharedInstance.satelliteListName = satName
                        }
                    }
                }
            }
        }
        task.resume()
    }

}

