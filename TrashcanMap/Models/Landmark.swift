//
//  Landmark.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/22.
//

import Foundation
import MapKit

struct Landmark: Identifiable, Hashable {
  
    let placemark: MKPlacemark
    
    let id = UUID()
    
    var title: String{
        self.placemark.name ?? ""
    }
    
    var subtitle: String {
        self.placemark.subtitle ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
