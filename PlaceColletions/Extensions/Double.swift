//
//  Double.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import Foundation

extension Double {
    
    // 거리 형식
    private var distanceFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter
    }
    
    func distanceInMetersString() -> String {
        return distanceFormatter.string(for: self / 1000) ?? ""
    }
    
}
