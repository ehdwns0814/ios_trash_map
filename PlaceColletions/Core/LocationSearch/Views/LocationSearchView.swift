//
//  LocationSearchView.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    
    var body: some View {
        VStack {
          
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                }
                VStack {
                    TextField("현재 위치", text:
                        $startLocationText)
                    .frame(height: 32)
                    .background(Color(
                        .systemGroupedBackground))
                    .padding(.trailing)
                    
                    TextField("목적지", text:
                                $viewModel.queryFragment)
                    .frame(height: 32)
                    .background(Color(.systemGray4))
                    .padding(.trailing)
                    
                    
                    
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            // list view
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results, id: \.self) {
                        result in
                        HStack{
                            // 목적지와 현위치 경로선 표시,
                            LocationSearchResultCell(
                                addCallback: viewModel.uploadFavoriteLocation,
                                title: result.title,
                                subTitle: result.subtitle,
                                authViewModel: authViewModel
                            )
                            .onTapGesture {
                                withAnimation( .spring()) {
                                    viewModel.selectLocation(result)
                                    mapState = .locationSelected
                                }
                            }
                            .padding(.trailing, 10)
                            Spacer()

                        }
                    }
                }
            }
             
                
            
        }
        .background(Color.theme.backgroundColor)
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.searchingForLocation))
    }
}
