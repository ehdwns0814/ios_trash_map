//
//  FavoriteView.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/14.
//
//
//import SwiftUI
//
//struct FavoriteView: View {
//    var body: some View {
//        VStack{
//            HStack{
//                Text("즐겨찾기")
//            }
//            .padding(.horizontal)
//            
////            ScrollView {
////                VStack(alignment: .leading) {
////                    ForEach(viewModel.results, id: \.self) {
////                        result in
////                        HStack{
////                            // 목적지와 현위치 경로선 표시,
////                            LocationSearchResultCell(title:
////                                result.title, subtitle:
////                                result.subtitle)
////                            .onTapGesture {
////                                withAnimation( .spring()) {
////
////                                    viewModel.selectLocation(result)
////                                    mapState = .locationSelected
////                                }
////                            }
////                            .padding(.trailing, 10)
////                            Spacer()
////
////                        }
////                    }
////                }
////            }
//            
//            
//            
//        }
//    }
//}
//
//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteView()
//    }
//}
