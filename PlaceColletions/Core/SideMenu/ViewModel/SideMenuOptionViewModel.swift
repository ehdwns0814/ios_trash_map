//
//  File.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import Foundation

// CaseIterable: forEach등으로 항목을 순회하기 위해
enum SideMenuOptionViewModel: Int, CaseIterable, Identifiable {
    case trips
    case wallet
    case settings
    case messages
    
    var title: String {
        switch self{
        case .trips: return "Your Trips"
        case .wallet: return "Wallet"
        case .settings: return "Settings"
        case .messages: return "Messages"
        }
    }
    
    var imageName: String {
        switch self {
        case .trips: return "list.bullet.rectangle"
        case .wallet: return "creditcard"
        case .settings: return "gear"
        case .messages: return "bubble.left"
        }
    }
    
    var id: Int {
        return self.rawValue
    }
}
