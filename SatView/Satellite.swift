//
//  Satellite.swift
//  SatView
//
//  Created by Jimmy Lai on 24/02/2022.
//

import Foundation
import MapKit

class Satellite: NSObject, MKAnnotation {
    let id: String?
    let name: String?
    let altitude: String?
    @objc dynamic var coordinate: CLLocationCoordinate2D

    init(
        id: String?,
        name: String?,
        altitude: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.id = id
        self.name = name
        self.altitude = altitude
        self.coordinate = coordinate

        super.init()
    }

    var subtitle: String? {
        return name
    }
}
