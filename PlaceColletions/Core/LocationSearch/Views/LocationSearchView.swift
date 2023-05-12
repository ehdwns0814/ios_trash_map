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
                            //네비게이션으로 네비게이션 뷰가 나오게 설정 @@
                            VStack{
                                Image(systemName: "figure.walk.circle")
                                    .resizable()
                                    .foregroundColor(.blue)
                                    .accentColor(.white)
                                    .frame(width: 40, height: 40)
                                Text("출발하기")
                                    .font(.system(size: 15))
                                    
                            }
                            .padding(.leading, 10)
                            .onTapGesture {
                                withAnimation( .spring()) {
                                    viewModel.selectLocation(result)
                                    mapState = .locationSelected
                                }
                            }
                            
                            // 지도를 확대하여 근처 위치의 지역을 을 표시
                            LocationSearchResultCell(title:
                                result.title, subtitle:
                                result.subtitle)
                            .onTapGesture {
                                withAnimation( .spring()) {
                                    // 하단 맵
//                                    viewModel.selectLocation(result)
//                                    mapState = .locationSelected
                                }
                            }
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
