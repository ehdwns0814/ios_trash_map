//
//  LocationSearchActivationView.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
                .resizable()
                .foregroundColor(.blue)
                .frame(width:20, height:20)
                .padding(.leading, 20)
                
            Text("목적지를 선택해주세요")
                .foregroundColor(Color(.darkGray))
               
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64,
               height: 50)
        .background(
            Capsule()
                .fill(Color.white)
                .shadow(color: .black, radius: 6)
        )
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
