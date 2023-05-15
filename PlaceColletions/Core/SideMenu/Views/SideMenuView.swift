//
//  SideMenuView.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    private let user: User
    
    init(user:User) {
        self.user = user
    }
    
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack(spacing: 40){
                // header view
                VStack(alignment: .leading, spacing: 32) {
                    // user info
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
                    
                    // become a driver
                    VStack(alignment: .leading, spacing: 16) {
                        Text("내가 간 곳을 기록해 보아요")
                            .font(.footnote)
                        .fontWeight(.semibold)
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "pencil.line")
                                    .font(.title2)
                                    .imageScale(.medium)
                                
                                Text("나의 발자국")
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(6)
                            }
                        }

                    }
                    
                    Rectangle()
                        .frame(width: 296, height: 0.75)
                        .opacity(0.7)
                        .foregroundColor(Color(.separator))
                        .shadow(color: .black.opacity(0.7), radius: 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                         
               // option list
                VStack {
                    ForEach(SideMenuOptionViewModel.allCases, id: \.self) { viewModel in
                        NavigationLink(value: viewModel) {
                            SideMenuOptionView(viewModel: viewModel)
                                .padding()
                        }
                    }
                }
                .navigationDestination(for: SideMenuOptionViewModel.self) {
                    viewModel in
                    Text(viewModel.title)
                }
                
                Spacer()
                
                // 로그아웃 버튼..
                Button {
                    authViewModel.signout()
                } label:{
                    Image(systemName: "rectangle.righthalf.inset.filled.arrow.right")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 22, height: 22)
                    Text("로그 아웃")
                }
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
            }
            .padding(.top, 32)

        }
    }
}

//struct SideMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuView(user: User(fullname: "John",
//                                email: "dong@gmail.com",
//                                uid: "123456"))
//    }
//}
