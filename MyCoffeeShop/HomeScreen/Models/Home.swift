//
//  HoneView.swift
//  MyCoffeeShopp
//
//  Created by Mennah on 05/05/2025.
//

import SwiftUI

struct HomeScreenn: View {
    var body: some View {
        VStack {
            Text("Welcome to Home Screen")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("This is your main app screen.")
                .font(.title3)
                .foregroundColor(.gray)
        }
        .navigationTitle("Home")
    }
}

#Preview {
    HomeScreenn()
}

