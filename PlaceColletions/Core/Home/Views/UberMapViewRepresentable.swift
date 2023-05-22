//
//  UberMapViewRepresentable.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    @State private var addresses: [String] = []
    @State private var annotations: [MKPointAnnotation] = []
    @Binding var mapState: MapViewState 
    @Binding var trashType: TrashType
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    // 지도를 만드는 역할을 담당
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
     
    //검색 시 업데이트 할때 사용
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("mapState: \(mapState)")
        
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedLocation?.coordinate {
                print("지도에 항목 추가")
                // 목적지를 주석으로 처리하고
                context.coordinator.addAndSelectedAnnotation(withCoordinate: coordinate)
                // 경로선을 그린다.
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        case .polylineAdded:
            break
        }
        
        switch trashType {
            
        case .generalTrash:
            break
        case .recyclableWaste:
            break
        case .cigaretteButt:
            break
        }
    }
    
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}

// 이 코디네이터는 기본적으로 우리 사이의 중개자처럼 사용
extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {

        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
   
        init(parent: UberMapViewRepresentable){
            self.parent = parent
            super.init()
        }
        
        // 현재 위치를 알려주는
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region =   MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            self.currentRegion = region
            
            // Mapview에서 보이는 지역을 변경
            parent.mapView.setRegion(region, animated: true)
        }
        
        // configurePolyline이 끝난 후에 지도에 경로선을 그려준다
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->
            MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
                polyline.strokeColor = .systemBlue
                polyline.lineWidth = 6
                return polyline
            }
        
       
        
        
    
        // 주석 표시하기
        func addAndSelectedAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            //새롭게 주석을 추가 하면 이전에 추가했던 주석을 지웁니다.
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
        }
    
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            parent.locationViewModel.getDestinationRoute(from: userLocationCoordinate,
                                to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .polylineAdded
                let rect  = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect,
                                                                edgePadding:.init(top: 64,
                                                                    left: 32,bottom: 500,
                                                                        right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true )
            }
        }
    

        func clearMapViewAndRecenterOnUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
        
        
        // 읽어온 csv파일에서 도로명주소 데이터를 추출한다.
        func extractAddresses(csv: [SeoulTrashCan]) -> [String] {
            
            var addresses: [String] = []

            for row in csv {
                addresses.append(row.detailRoadName)
            }
            
            return addresses
        }
         
        // 주소로 부터 위치를 받아오는 함수
        func getLocationFromAddress() -> CLLocationCoordinate2D {
            
            return CLLocationCoordinate2D()
        }


        func convertAddressesToCoordinates(_address: [String]) {
            let geocoder = CLGeocoder()
            
            for address in addresses {
                geocoder.geocodeAddressString(address) { (placemarks, error) in
                    if let error = error {
                        print("Geocoding error: \(error.localizedDescription)")
                        return
                    }
                    
                    if let placemark = placemarks?.first,
                       let location = placemark.location {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location.coordinate
                        annotations.append(annotation)
                    }
                }
            }
        }

    }
}
