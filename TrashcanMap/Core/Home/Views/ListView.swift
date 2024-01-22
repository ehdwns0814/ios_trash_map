//
//  listView.swift
//  TrashcanMap
//
//  Created by 동준 on 1/23/24.
//

import SwiftUI
import Foundation

struct Item: Codable {
    let id: Int
    let name: String
}

func parseJSONData() -> [Item]? {
    guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let items = try decoder.decode([Item].self, from: data)
        return items
    } catch {
        print("JSON 파싱 에러: \(error.localizedDescription)")
        return nil
    }
}

struct ListView: View {
    let items: [Item] = parseJSONData() ?? []
    
    var body: some View {
        List(items, id: \.id) { item in
            Text(item.name)
        }
    }
}

#Preview {
    ListView()
}
