//
//  Users.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//
// 데이터 베이스에 보낼 땐 incode
// 데이버 베이스에서 정보는 받을 때는 decode

import FirebaseFirestoreSwift
// user의 uid로 아이디를 구별해서 id에 저장한다.
struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let fullname : String
    let email: String
    let profileImageUrl: String
}
