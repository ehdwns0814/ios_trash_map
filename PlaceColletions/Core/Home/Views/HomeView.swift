//
//  HomeView.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @State private var showSideMenu = false
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil{
                LoginView()
            }else if let user = authViewModel.currentUser {
                // sideMenuView에서 navigationlink 사용시 화면이 사이드 메뉴 사이드에서 작동함
                NavigationStack {
                    ZStack{
                        if showSideMenu {
                            SideMenuView(user: user)
                        }
                        mapView
                            .offset(x: showSideMenu ? 316 : 0)
                            .shadow(color: showSideMenu ? .black: .clear, radius: 10 )
                    }// navigationlink가 발생하였을때 showSideMenu 값을 false로 변경한다.
                    .onAppear {
                        showSideMenu = false
                    }
                }
            }
        }
    }
}

extension HomeView {
    var mapView: some View {
        ZStack(alignment: .bottom){
            ZStack(alignment: .top) {
                UberMapViewRepresentable(mapState: $mapState)
                    // 상단의 빈 공간도 꽉 차게
                    .ignoresSafeArea()
        
               
                
                // 상단은 검색 하단은 지도뷰
                if mapState == .searchingForLocation {
                    LocationSearchView(mapState: $mapState)
                        .environmentObject(authViewModel)
                
                } else if mapState == .noInput {
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState
                                    ,showSideMenu: $showSideMenu)
                    .padding(.leading)
                    .padding(.top, 4)
            }
            
            if mapState == .locationSelected || mapState == .polylineAdded{
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) {
            location in
            if let location = location {
                locationViewModel.userLocation = location
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
            
    }
}
