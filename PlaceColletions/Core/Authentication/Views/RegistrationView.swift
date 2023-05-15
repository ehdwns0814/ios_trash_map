//
//  RegistrationView.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI

struct RegistrationView: View {
    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack{
            
            // 회원가입 정보 업로드 후에 작동한다.
            NavigationLink(destination: ProfilePhotoSelectorView(),
                            isActive: $viewModel.didAuthenticateUser,
                            label: { })
                    
            Color("Profile")
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    // 뒤로 가기 버튼을 입력하면 registrationview pop한다
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding()
                }
                
                Text("새로운 계정 만들기")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250)
                
                Spacer()
                
                VStack {
                    VStack(spacing: 56) {
                        CustomInputField(text: $fullname,
                                         title: "이름",
                                         placeholder: "이름을 입력해주세요")
                        CustomInputField(text: $email,
                                         title: "이메일 아이디",
                                         placeholder: "ex) dong01@example.com")
                        CustomInputField(text: $password,
                                         title: "비밀번호",
                                         placeholder: "Enter your password",
                                         isSecureField:true)
                                        
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button {
                        viewModel.registerUser(withEmail: email,
                                               password: password,
                                               fullname: fullname
                            )
                    } label: {
                        HStack{
                            Text("가입하기")
                                .foregroundColor(.black)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Spacer()
                }
            }
            .foregroundColor(.white)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
