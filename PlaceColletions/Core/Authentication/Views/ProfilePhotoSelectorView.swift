//
//  ProfilePhotoSelectorView.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/13.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var showImagePicker = false
    //UIImage -> UIKit
    @State private var selectedImage: UIImage?
    // Image -> SwiftUI
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack { Spacer() }
                
                Text("프로필 이미지")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("등록하기")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .frame(height: 260)
            .padding(.leading)
            .background(Color("Profile"))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight]))

            
            Button{
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .modifier(ProfileImageModifier())
                        .clipShape(Circle())
                } else {
                    Image("plus_photo")
                        .resizable()
                        .renderingMode(.template)
                        .modifier(ProfileImageModifier())
                    
                }
            }
            //loadImage가 실행되면 창을 닫는다. UIkit 이미지를 swiftui 형식으로 받아오는 loadImage함수를 실행
            .sheet(isPresented: $showImagePicker,
                   onDismiss: loadImage){
                //selectedImage에 ImagePicker에서 선택한 이미지를 담는다
                ImagePicker(selectedImage: $selectedImage)
            }
            .padding(.top, 44)
            
            // 이미지가 있다면 계속하기 버튼 띄우기
            if let selectedImage = selectedImage {
                Button {
                    viewModel.uploadProfileImage(selectedImage)
                } label: {
                     Text("계속하기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color("Profile"))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

// 이미지 형식 2번 사용하므로 만들었다.
private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("Profile"))
            .scaledToFill()
            .frame(width: 180, height: 180)
            
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}


