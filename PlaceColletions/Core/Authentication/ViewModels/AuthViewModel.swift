//
//  AuthViewModel.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI
import Firebase



class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    //프로필 이미지 등록 전 까지는 userSession이 값을 가지면 main화면으로 이동하기에 변수를 또 만듦
    private var tempUserSession: FirebaseAuth.User?
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result , error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
         
            self.userSession = result?.user
            print("유저가 로그인하였습니다.")
        }
    }
    
    // User를 만들고 난 후에 얻는 results를 업로드 한다.
    func registerUser(withEmail email: String, password: String, fullname: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign up with error \(error.localizedDescription)")
                return
            }
            // 에러가 발생하지 않는 다면 다음 문자을 실행
            
            // firebase서버에 있는 user 밑의 User와는 다르다
            guard let firebaseUser = result?.user else { return }
            self.tempUserSession = firebaseUser

            
            print("유저등록 성공")
            print("User는 \(self.userSession)")
            
            let user = User(fullname: fullname, email: email, uid: firebaseUser.uid)
            // 데이터 베이스에 유저 정보를 인코딩
            guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
            
            // 데이터 업로드
            Firestore.firestore().collection("users")
                .document(firebaseUser.uid)
                // 인코딩한 데이터 업로드
                .setData(encodedUser) { _ in
                    self.didAuthenticateUser = true
                }
        }
    }
    
    func signout() {
        do {
            //firebase 서버 (백엔드) 로그아웃
            try Auth.auth().signOut()
            // 화면 (프론트) 로그아웃
            print("로그아웃")
            self.userSession = nil
        } catch let error {
            print("로그인 실패 에러내용: \(error.localizedDescription)")
        }
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        // 현재 로그인 된 유저의 snapshot을 돌려받고
        
        service.fetchUser(withUid: uid)
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }

            guard let user = try? snapshot.data(as: User.self) else {
                return
            }
            self.currentUser = user
        }
    }
}
 
