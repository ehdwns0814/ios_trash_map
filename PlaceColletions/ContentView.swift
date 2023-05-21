//
//  ContentView.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var TrashCandex :[SeoulTrashCan]
    
    var body: some View {
        NavigationView {
            List {
                ForEach (TrashCandex) { SeoulTrashCan in
                    NavigationLink(destination: {} ) {
                        HStack{
                            Text("#"+String(format: "%03d",SeoulTrashCan.id))
                                .font(.subheadline)
                            Text(SeoulTrashCan.자치구명)
                                .font(.headline)
                            Spacer()
                            
                            reusableTypeView(thisTrashType: SeoulTrashCan.쓰레기종류)

                        }
                    }
                }
            }
            .navigationTitle("pokendex")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(TrashCandex: loadCSVData(trashType: .generalTrash))
    }
}


struct reusableTypeView: View {
    var thisTrashType: String
    var body: some View {
        Text(thisTrashType)
            .font(.system(size: 10))
            .foregroundColor(.white)
            .padding()
            .background(Color(.black))
            .cornerRadius(10)
    }
}
