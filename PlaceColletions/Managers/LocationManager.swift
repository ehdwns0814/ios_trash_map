//
//  LocationManager.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//  사용자의 실제 위치를 찾는다 장치의 지리적 위치를 주기적으로 업데이트하거나 장치가 지정된 지리적 위치에 근접할 떄 알림을 받을 수 있습니다.

import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion.defaultRegion()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 가장높은 정확도
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() 
    }
}

extension LocationManager: CLLocationManagerDelegate {
    // 사용자 위치를 파악하고 업데이트
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        // 검색한 정보를 얻어온 후에 지속적으로 같은 정보를 얻어올 필요가 없어서 사용
        locationManager.stopUpdatingLocation()
    }
}
