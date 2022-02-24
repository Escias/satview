//
//  ApiSat.swift
//  SatView
//
//  Created by administration4 on 23/02/2022.
//

import UIKit

class ApiSat {

    struct sat {
           
            let name: String
            let latitude: String
            let longitude: String
            let id: Int
            
        }
    
    let url = "https://tle.ivanstanojevic.me/api/tle"
    
    public static let apiSat = ApiSat()
    
    private init() {}
    
    func getByName(name: String) {
        let urlSearch = URL(string: url + "?search=" + name)
         requestWithUrl(url: urlSearch!) {results in
            for item in results! {
                let satellite = sat.init(name: item["name"] as! String, latitude: item["line1"] as! String, longitude: item["line2"] as! String, id: item["satelliteId"] as! Int)
                print("nous sommes dedans")
                print(satellite)
                return satellite
            }
            return nil
        }
    }
    
    public func requestWithUrl(url: URL, completion: @escaping ([[String: AnyObject]]?) -> (sat?) ) {
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
