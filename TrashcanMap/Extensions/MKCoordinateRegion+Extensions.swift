//
//  MKCoordinateRegion+Extensions.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/25.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.03121860), span:
                            MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
    }
}
