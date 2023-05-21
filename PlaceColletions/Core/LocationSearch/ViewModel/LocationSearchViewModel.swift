//
//  LocationSearchViewModel.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject{
    
    @Published var results = [MKLocalSearchCompletion]()
    // 위치 property를 published하면 mapview가 알아 챈다.
    @Published var selectedLocation: Location?
    @Published var tripDistanceMeters: String?

    
    // 검색 완료 객체
    private let searchCompleter = MKLocalSearchCompleter()
    
    // 텍스트 결과 값이 바뀔 때 마다
    var queryFragment: String = ""{
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    

    // 검색어을 받아서 위치 좌표를 찾기
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("위치검색 실패 에러내용: \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocation = Location(title: localSearch.title,
                coordinate: coordinate)
            print("위치 좌표: \(coordinate)")
        }
    }
    
 
    
    // 위치검색
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        // 검색 결과의 부제인 주소 정보를 넘겨준다
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeDistance() -> Double {
        guard let destCoordintate = selectedLocation?.coordinate else { return 0.0}
        guard let userCoordinate = self.userLocation else { return 0.0}
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude,
                                      longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordintate.latitude,
                                     longitude: destCoordintate.longitude)
        
        let tripDistanceMeters = userLocation.distance(from:  destination)
        return tripDistanceMeters
    }
    
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D,
                             to destination: CLLocationCoordinate2D,
                             completion: @escaping(MKRoute) -> Void){
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destPlacemark)
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error {
                print("방향 정보가져오기 실패 에러내용: \(error.localizedDescription)")
                return
            }
            
            // 일반적으로 가져오는 루트 중 첫번째 루트가 가장빠르므로 첫 번째 경로를 할당한다
            guard let route =  response?.routes.first else { return }
            completion(route)
        }
    }
}

//쿼리 조각을 기반으로 검색이 완료 되면 호출된다
//위치 자동 완성
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
        print("locationSearchViewModel 호출")
    }
}
