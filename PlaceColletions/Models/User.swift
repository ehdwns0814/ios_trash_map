//
//  Users.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//
// 데이터 베이스에 보낼 땐 incode
// 데이버 베이스에서 정보는 받을 때는 decode


import Foundation

struct User: Codable {
    let fullname : String
    let email: String
    let uid: String
}
