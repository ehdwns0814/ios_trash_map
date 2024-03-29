//
//  File.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import Foundation

// CaseIterable: forEach등으로 항목을 순회하기 위해
enum SideMenuOptionViewModel: Int, CaseIterable, Identifiable {
    case favorite
    case wallet
    case settings
    
    var title: String {
        switch self{
        case .favorite: return "즐겨찾기"
        case .wallet: return "지갑"
        case .settings: return "설정"
        }
    }
    
    var imageName: String {
        switch self {
        case .favorite: return "star.square"
        case .wallet: return "creditcard"
        case .settings: return "gear"
        }
    }
    
    var id: Int {
        return self.rawValue
    }
}
