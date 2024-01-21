//
//  Users.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//


import FirebaseFirestoreSwift
struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let fullname : String
    let email: String
    let profileImageUrl: String
}
