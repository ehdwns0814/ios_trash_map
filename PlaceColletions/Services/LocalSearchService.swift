//
//  LocalSearchService.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/11.
//

//import Foundation
//import MapKit
//import Combine
//
//class LocalSearchService: ObservableObject {
//    
//    @Published var region: MKCoordinateRegion = MKCoordinateRegion.defaultRegion()
//    let locationManager = LocationManager()
//    var cancellables = Set<AnyCancellable>()
//    @Published var landmarks: [Landmark] = []
//     
//    init() {
//        locationManager.$region.assign(to: \.region, on: self)
//            .store(in: &cancellables)
//    }
//    
//    func search(query: String) {
//        
//        let request = MKLocalSearch.Request()
//        // 검색어 전달
//        request.naturalLanguageQuery = query
//        // 현 위치에서 설정한 구역내로 조 회
//        request.region = locationManager.region
//        
//        let search = MKLocalSearch(request: request)
//        search.start { response, error in
//            if let response = response {
//                let mapItems = response.mapItems
//           
//                self.landmarks = mapItems.map {
//                    Landmark(placemark: $0.placemark)
//                }
//            }
//        }
//        
//    }
//}
