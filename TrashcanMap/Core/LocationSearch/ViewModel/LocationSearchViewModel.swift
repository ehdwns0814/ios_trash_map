//
//  LocationSearchViewModel.swift
//  TrashcanMap
//
//  Created by 동준 on 1/22/24.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    // MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    
    override init() {
        
    }
}
