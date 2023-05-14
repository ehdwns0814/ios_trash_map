//
//  RideRequestView.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI

struct RideRequestView: View {
    @EnvironmentObject var locationViewModel: LocationSearchViewModel

    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            // trip info view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 32)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("현재 위치")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                    }
                    .padding(.bottom,10)
                    
                    HStack {
                        if let location = locationViewModel.selectedLocation {
                            Text(location.title)
                                .font(.system(size: 16, weight:
                                        .semibold))
                        }
                            
                        Spacer()
                    }
                }.padding(.leading, 8)
            }
            .padding()
            
            Divider()
            
            // 목적지 까지의 거리
            HStack {
                Text("목적지 까지의 거리:")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray)
                Text(locationViewModel.computeDistance().distanceInKiloMetersString())
                    .font(.system(size: 14, weight:.semibold))
                Text("Km")
                    .font(.system(size: 14, weight:.semibold))
                Spacer()
            }
            .padding(.leading)
            
            Divider()
                .padding(.vertical, 8)
                        
            //장소 저장하기
            Button{
                
            } label: {
                Text("장소 기억하기")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width -
                           32, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 24)
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
