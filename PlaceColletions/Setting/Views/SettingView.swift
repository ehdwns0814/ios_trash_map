//
//  SettingView.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/15.
//

import SwiftUI
import Kingfisher


struct SettingView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack{
            List {
                Section {
                    if let user = authViewModel.currentUser {
                        HStack{
                            HStack {
                                KFImage(URL(string: user.profileImageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 64, height: 64)
                                
                                VStack(alignment: .leading, spacing: 8){
                                    Text(user.fullname)
                                        .font(.system(size:16, weight: .semibold))
                                    
                                    Text(user.email)
                                        .font(.system(size: 14))
                                        .accentColor(Color.theme.primaryTextColor)
                                        .opacity(0.77)
                                }
                            }
                        }
                    }
                }
                
                Section("Favorites") {
                    HStack(spacing: 12) {
                        Image(systemName: "house.circle.fill")
                            .imageScale(.medium)
                            .font(.title)
                            .foregroundColor(Color(.systemBlue))
                        VStack(alignment: .leading, spacing: 4) {
                            Text("집")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Color.theme.primaryTextColor)
                            Text("집 주변 장소")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    HStack(spacing: 12) {
                        Image(systemName: "archivebox.circle.fill")
                            .imageScale(.medium)
                            .font(.title)
                            .foregroundColor(Color(.systemBlue))
                        VStack(alignment: .leading, spacing: 4) {
                            Text("직장")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Color.theme.primaryTextColor)
                            Text("직장 주변 장소")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section("Settings") {
                    HStack(spacing: 12) {
                        Image(systemName: "bell.circle.fill")
                            .imageScale(.medium)
                            .font(.title)
                            .foregroundColor(Color(.systemBlue))
                        VStack(alignment: .leading, spacing: 4) {
                            Text("알림 설정")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Color.theme.primaryTextColor)
                        }
                    }
                    HStack(spacing: 12) {
                        Image(systemName: "creditcard.circle.fill")
                            .imageScale(.medium)
                            .font(.title)
                            .foregroundColor(Color(.systemBlue))
                        VStack(alignment: .leading, spacing: 4) {
                            Text("지갑")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Color.theme.primaryTextColor)
                        }
                    }
                }
                
            }
        }
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
////        SettingView()
////            .environmentObject(AuthViewModel)
//    }
//}
