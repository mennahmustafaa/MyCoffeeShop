//
//  BottomToolbarViewModel.swift
//  MyCoffeeShop
//
//  Created by Mennah on 30/06/2025.
//

import Foundation
import SwiftUI

class ToolbarViewModel: ObservableObject {
    @Published var selectedTab: String = "home"

    let items: [ToolbarItemModel] = [
        ToolbarItemModel(title: "Home", systemImage: "house.fill", tag: "home"),
        ToolbarItemModel(title: "Favorites", systemImage: "heart", tag: "favorites"),
        ToolbarItemModel(title: "Cart", systemImage: "cart", tag: "cart")
    ]

    func select(tab: String) {
        selectedTab = tab
        print("Selected tab: \(tab)")
    }
}

