//
//  TrashModel.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/21.
//

import Foundation

// CaseIterable: forEach등으로 항목을 순회하기 위해
enum TrashModel: Int, CaseIterable, Identifiable {
    case generalTrash
    case recyclableWaste
    case cigaretteButt
    
    var title: String {
        switch self{
        case .generalTrash: return "일반쓰레기"
        case .recyclableWaste: return "재활용쓰레기"
        case .cigaretteButt: return "담배꽁초"
        }
    }
        
    var id: Int {
        return self.rawValue
    }
}
