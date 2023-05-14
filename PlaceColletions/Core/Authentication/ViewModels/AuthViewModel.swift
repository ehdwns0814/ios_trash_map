//
//  AuthViewModel.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var didAuthenticateUser  = false
    private var tempUserSession: FirebaseAuth.User?
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result , error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
         
            self.userSession = result?.user
        }
    }
    
    func registerUser(withEmail email: String, password: String, fullname: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign up with error \(error.localizedDescription)")
                return
            }
            // 에러가 발생하지 않는 다면 다음 문자을 실행
            
            // firebase서버에 있는 user 밑의 User와는 다르다
            guard let firebaseUser = result?.user else { return }
//            self.userSession = firebaseUser
            
            
            let user = User(fullname: fullname, email: email, uid: firebaseUser.uid)
            // 데이터 베이스에 유저 정보를 인코딩하여 보낸다.
            guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
            
            Firestore.firestore().collection("users")
                .document(firebaseUser.uid)
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
            self.userSession = nil
        } catch let error {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
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
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            
            guard let user = try? snapshot.data(as: User.self) else { return }
            self.currentUser = user
        }
    }
}
 
