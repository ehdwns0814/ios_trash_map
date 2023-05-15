//
//  LocationSearchResultCell.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title: String
    let subtitle: String
    @State var isFavorite: Bool = false
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                
                Text(subtitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
                
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
            
            Button {
                // 즐겨찾기 추가 기능
                isFavorite.toggle()
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
            }
        }
        .padding(.leading, 10)
    }
}

//struct LocationSearchResultCell_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationSearchResultCell(title: "Starbucks",
//                subtitle: "123 Main St")
//    }
//}
