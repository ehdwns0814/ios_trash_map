//
//  UserService.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/15.
//

import Firebase
import FirebaseFirestoreSwift  //decode 하기위해

struct UserService {
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void ) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self)
                else {
                    return
                }
                completion(user)
        }
    }
}
