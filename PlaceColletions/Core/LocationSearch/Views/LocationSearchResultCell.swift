//
//  LocationSearchResultCell.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title: String
    let subTitle: String
    @State var isFavorite: Bool = false
    var addCallback: (_ title: String, _ subtitle: String, _ auth: AuthViewModel)-> Void
    var authViewModel: AuthViewModel
    init(addCallback: @escaping (_ title: String, _ subtitle: String, _ authVM: AuthViewModel) -> Void,
         title: String,
         subTitle: String,
         authViewModel: AuthViewModel
    ) {
        self.title = title
        self.subTitle = subTitle
        self.addCallback = addCallback
        self.authViewModel = authViewModel
    }
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                
                Text(subTitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
                
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
            
            Button {
                // 즐겨찾기 추가 기능
                isFavorite.toggle()
                addCallback(title,subTitle,authViewModel)
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
            }
        }
        .padding(.leading)
    }
}

//struct LocationSearchResultCell_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationSearchResultCell(title: "Starbucks",
//                subtitle: "123 Main St")
//    }
//}
