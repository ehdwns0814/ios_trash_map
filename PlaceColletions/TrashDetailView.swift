//
//  TrashDetailView.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/20.
//

import SwiftUI

struct TrashDetailView: View {
    var thisTrash: SeoulTrashCan
    
    var body: some View {
        List {
            Section("Name") {
                HStack {
                    Text("ID:")
                    Spacer()
                    Text("#"+String(format: "%03d",thisTrash.id))
                }
                HStack{
                    Text("Name:")
                    Spacer()
                    Text(thisTrash.detailRoadName)
                }
            }
        }.onAppear{
//            thisTrash = loadCSVData(trashType: .generalTrash)
        }
    }
}

struct TrashDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TrashDetailView(thisTrash: loadCSVData(trashType: .generalTrash).first!)
    }
}
