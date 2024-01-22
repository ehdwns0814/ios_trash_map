//
//  HomeView.swift
//  TrashcanMap
//
//  Created by 동준 on 1/22/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        MapViewRepresentable()
            .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
