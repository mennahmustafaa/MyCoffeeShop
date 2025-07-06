//
//  CoffeeList.swift
//  MyCoffeeShop
//
//  Created by Mennah on 30/06/2025.
//


import SwiftUI

struct CoffeeGridView: View {
    @ObservedObject var viewModel: CoffeeListViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.finalFilteredItems, id: \.id) { item in
                CoffeeCardView(item: item)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16) // Optional: adjust as needed
    }
}
