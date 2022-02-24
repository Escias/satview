//
//  ApiSat.swift
//  SatView
//
//  Created by administration4 on 23/02/2022.
//

import UIKit
import MapKit

class ApiSat {

    /*struct sat {
           
            let name: String
            let latitude: String
            let longitude: String
            let id: Int
            
        }*/
    let url = "https://tle.ivanstanojevic.me/api/tle"
    
    public static let apiSat = ApiSat()
    
    private init() {}
    
    func getByName(name: String) {
        var urlSearch = URL(string: url + "?search=" + name)
        requestWithUrl(url: urlSearch!) {results in
            for item in results! {
                //var coordinates = CLLocationCoordinate2D(latitude: item["line1"] as! Double, longitude: item["line2"] as! Double)
                //print(type(of: item["satelliteId"]))
                print("on entre une première fois")
                let id = String(describing: item["satelliteId"])
                urlSearch = URL(string: self.url + "/" + id + "/propagate")
                self.requestWithUrl(url: urlSearch!) { results in
                    print("C'est ici ue ça e passe : " + String(describing: results))
                }
                //return satellite
            }
            //return nil
        }
    }
    
    public func requestWithUrl(url: URL, completion: @escaping ([[String: AnyObject]]?) -> () ) {
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

}
