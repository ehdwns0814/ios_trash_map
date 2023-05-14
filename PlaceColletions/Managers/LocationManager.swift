//
//  LocationManager.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//  사용자의 실제 위치를 찾는다

import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion.defaultRegion()
    
    override init() {
        super.init() //NSObject에서 상속받기 때문에
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  // 배터리로 동작 할떄 권장되는 가장 높은 수준의 정확도
        locationManager.requestWhenInUseAuthorization() // 위치 사용 권한
        locationManager.startUpdatingLocation()   // 사용자의 위치 업데이트를 시작하여 해당 사용자 위치에 엑세스 할 수 있음
        locationManager.requestLocation() // 업데이트 위치를 실행하지 않을 때 위치를 제공
        locationManager.distanceFilter = kCLDistanceFilterNone // 어느 정도 거리 위치 변화가 생겼을 때 어플리케이션이 알람을 받을지 말지를 설정(기본값)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    private func checkAuthorization() {
        
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("당신의 위치 정보는 제한되어있습니다.")
            case .denied:
                print("당신은 어플이 위치 서비스에 접근하는 것에 동의 하지 않았습니다.")
            case .authorizedAlways, .authorizedWhenInUse:
            guard let location = locationManager.location else { return }
            region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        @unknown default:
            break
        }
    }
    
    // 사용자의 위치를 파악하거나 업데이트 하는 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:
            [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        // 사용자의 위치를 업데이트 한 후 반복적으로 위치를 얻을 필요가 없기에 더 이상의 업데이트를 중지한다.
        locationManager.stopUpdatingLocation( )
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
    
    //오류가 발생하면 콘솔에 알림
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
