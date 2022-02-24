//
//  Satellite.swift
//  SatView
//
//  Created by Jimmy Lai on 24/02/2022.
//
import Foundation
import MapKit

class Satellite: NSObject, MKAnnotation {
    let id: Int?
    let name: String?
    let altitude: Double?
    @objc dynamic var coordinate: CLLocationCoordinate2D

    init(
        id: Int?,
        name: String?,
        altitude: Double?,
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
