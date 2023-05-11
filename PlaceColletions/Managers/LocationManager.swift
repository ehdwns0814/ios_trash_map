//
//  LocationManager.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest 
        locationManager.requestWhenInUseAuthorization() // 위치 사용 권한
        locationManager.startUpdatingLocation()   // 사용자의 위치 업데이트를 시작하여 해당 사용자 위치에 엑세스 할 수 있음
        locationManager.requestLocation()
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
//    private func checkAuthorization() {
//        switch locationManager.authorizationStatus {
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
    
    // 사용자의 위치를 파악하거나 업데이트 하는 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:
            [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        // 사용자의 위치를 업데이트 한 후 반복적으로 위치를 얻을 필요가 없기에 더 이상의 업데이트를 중지한다.
        locationManager.stopUpdatingLocation( )
    }
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkAuthorization()
//    }
}
