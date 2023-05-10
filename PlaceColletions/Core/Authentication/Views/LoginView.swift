//
//  LoginView.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                
                VStack {
                    
                    // image and title
                    
                    VStack(spacing: -16) {
                        //image
                        Image("uber-app-icon")
                            .resizable()
                            .frame(width:200, height:  200)
                        
                        // title
                        Text("UBer")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    
                    // input fields
                    VStack(spacing: 32){
                        // input field 1
                        CustomInputField(text: $email,
                                         title: "Email Adrress",
                                         placeholder: "name")
                        
                        // input field 2
                        CustomInputField(text: $password,
                                         title: "Password",
                                         placeholder: "Enter your password",
                                        isSecureField: true)
                        Button {
                            
                        } label: {
                            Text("Forgot Password?")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                                
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                        
                   

                    // social sign in view
                    VStack {
                        // dividers + text
                        HStack(spacing: 24) {
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundColor(.white)
                                .opacity(0.5)
                            
                            Text("Sign in with social")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundColor(.white)
                                .opacity(0.5)
                        }
                        // sign up buttons
                        HStack(spacing: 24) {
                            Button {
                                
                            } label: {
                                Image("facebook-sign-in-icon")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                            }

                            Button {
                                
                            } label: {
                                Image("google-sign-in-icon")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    // sign in button
                    Button {
                        viewModel.signIn(withEmail: email, password: password)
                    } label: {
                        HStack{
                            Text("Sign in ")
                                .foregroundColor(.black)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    }
                    .background(Color.white)
                    .cornerRadius(10)

                    
                    // sign up button
                    
                    Spacer()
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack{
                            Text("계정이 없으신가요?")
                                .font(.system(size:14))
                            Text("회원가입")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
