//
//  LocationSearchViewModel.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject{
    
    // 검색어와 가장 가까운 위치를 찾기 위해 사용
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocation: Location?
    @Published var tripDistanceMeters: String?
    @Published var pickupTime: String?
    @Published var dropOffTime: String?
    
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
    

    //
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
    
    //
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
            self.configurePickupAndDropoffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickupAndDropoffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"

        pickupTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
}

//쿼리 조각을 기반으로 검색이 완료 되면 호출된다
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter){
        self.results = completer.results
    }
}
