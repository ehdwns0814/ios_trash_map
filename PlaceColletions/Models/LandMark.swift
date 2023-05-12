//
//  LandMark.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/11.
//

import Foundation
import MapKit

struct LandMark: Identifiable, Hashable {
    
    let placemark: MKPlacemark
    
    let id = UUID()
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
    
    
}
