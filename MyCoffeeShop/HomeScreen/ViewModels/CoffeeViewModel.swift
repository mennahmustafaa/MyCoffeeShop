//
//  CoffeeViewModel.swift
//  MyCoffeeShop
//
//  Created by Mennah on 27/06/2025.
//
import Foundation
import SwiftUI

class CoffeeListViewModel: ObservableObject {
    @Published var coffeeItems: [CoffeeItem] = []
    @Published var selectedCoffee: String = "All"
    @Published var searchText: String = ""
    @Published var scrollToCoffeeID: String? = nil

    init() {
        loadCoffeeData()
    }

    private func loadCoffeeData() {
        coffeeItems = [
            CoffeeItem(id: 1, name: "Caffe Mocha", subtitle: "Deep Foam", price: 4.53, imageName: "mocha"),
            CoffeeItem(id: 2, name: "Flat White", subtitle: "Espresso", price: 3.53, imageName: "flatwhite"),
            CoffeeItem(id: 3, name: "Latte", subtitle: "Creamy", price: 3.99, imageName: "latte"),
            CoffeeItem(id: 4, name: "Cappuccino", subtitle: "Foamy", price: 4.20, imageName: "cappuccino"),
            CoffeeItem(id: 5, name: "Caramel Macchiato", subtitle: "Sweet Layers", price: 4.75, imageName: "caramelmacchiato"),
            CoffeeItem(id: 6, name: "Iced Matcha", subtitle: "Cold & Sweet", price: 4.10, imageName: "matcha")
        ]
    }

    var finalFilteredItems: [CoffeeItem] {
        let categoryFiltered = selectedCoffee == "All"
            ? coffeeItems
            : coffeeItems.filter { $0.name == selectedCoffee }

        if searchText.isEmpty {
            return categoryFiltered
        } else {
            return categoryFiltered.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

    func selectCoffee(title: String) {
        selectedCoffee = title
        scrollToCoffeeID = title
    }
}

