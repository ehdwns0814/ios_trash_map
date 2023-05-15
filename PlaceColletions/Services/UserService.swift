//
//  UserService.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/15.
//

import Firebase

struct UserService {
    
    func fetchUser(withUid uid: String) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let data = snapshot?.data() else { return }
                
                print("유저 데이터는 \(data)")
            }
        
    }
}
