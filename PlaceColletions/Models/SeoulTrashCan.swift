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
    let borough: String
    let roadName: String
    let detailRoadName: String
    let installationPoint: String
    let trashType: String
    
    init(raw:[String]) {
        self.id = Int(raw[0])!
        self.borough = raw[1]
        self.roadName = raw[2]
        self.detailRoadName = raw[3]
        self.installationPoint = raw[4]
        self.trashType = raw[5]
    }
}
