//
//  SeoulTrashCan.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/19.
//

import Foundation


// Source of the CSV Data:서울시 공공데이터

//;연번;자치구명;도로명;위치;설치지점;쓰레기종류
struct SeoulTrashCan: Identifiable, Codable {
    let id: Int
    let 자치구명: String
    let 도로명: String
    let 위치: String
    let 설치지점: String
    let 쓰레기종류: String
    
    init(raw:[String]) {
        self.id = Int(raw[0])!
        self.자치구명 = raw[1]
        self.도로명 = raw[2]
        self.위치 = raw[3]
        self.설치지점 = raw[4]
        self.쓰레기종류 = raw[5]
    }
}
