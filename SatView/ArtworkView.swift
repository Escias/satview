//
//  ArtworkView.swift
//  SatView
//
//  Created by Jimmy Lai on 23/02/2022.
//

import Foundation
import MapKit

class ArtworkView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      guard let artwork = newValue as? Artwork else {
        return
      }

      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

      image = artwork.image
    }
  }
}
