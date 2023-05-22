//
//  TrashModel.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/21.
//
import SwiftUI
import MapKit

struct MapView: View {
    @State private var addresses: [String] = []
    @State private var annotations: [MKPointAnnotation] = []

    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5, longitude: 127.0), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)))), showsUserLocation: true, annotationItems: annotations) { annotation in
            MapPin(coordinate: annotation.coordinate, tint: .red)
        }
        .onAppear {
            let csv = readCSVFile()
            addresses = extractAddresses(from: csv)
//            convertAddressesToCoordinates()
        }
    }

    func readCSVFile() -> CSV {
        let path = Bundle.main.path(forResource: "주소파일", ofType: "csv")!
        let csv = try! CSV(url: URL(fileURLWithPath: path))
        return csv
    }

    func extractAddresses(from csv: CSV) -> [String] {
        var addresses: [String] = []

        for row in csv.rows {
            if let address = row.first {
                addresses.append(address)
            }
        }

        return addresses
    }

    func convertAddressesToCoordinates() {
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
