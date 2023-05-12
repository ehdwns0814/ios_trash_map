//
//  SeveralView.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/11.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @EnvironmentObject var localSearchService: LocalSearchService
    @State private var search: String = ""
    
    var body: some View {
        VStack {
            TextField("Search", text: $search)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    // search nearby places
                }.padding()
            
            List(1...20, id: \.self) { index in
                Text("Landmarks will be displayed here,")
            }
            
            Map(coordinateRegion: $localSearchService.region, showsUserLocation: true,
                annotationItems: localSearchService.landmarks) { landmark in
                
                MapAnnotation(coordinate: landmark.coordinate){
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
            
            
            Spacer()
        }
    }
}

struct SeveralView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LocalSearchService())
    }
}
