//
//  SearchView.swift
//  MyCoffeeShopp
//
//  Created by Mennah on 05/05/2025.
//

import SwiftUI

// Model for coffee item
struct CoffeeItem: Identifiable {
    var id = UUID()
    var name: String
}

struct SearchView: View {
    @Binding var searchText: String
    var coffeeItems: [CoffeeItem]  // List of coffee items
    
    // Filtered items based on search text
    var filteredItems: [CoffeeItem] {
        coffeeItems.filter { item in
            searchText.isEmpty || item.name.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("Search coffee", text: $searchText)
                        .font(.subheadline)
                        .disableAutocorrection(true)
                }
                .padding(8)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(8)

                Button(action: {
                    // TODO: Add filter action
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .padding(10)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 12)

            // Display filtered coffee items
            List(filteredItems) { coffee in
                Text(coffee.name)
            }
        }
    }
}

#Preview {
    // Mock data for coffee items
    SearchView(searchText: .constant(""), coffeeItems: [
        CoffeeItem(name: "Espresso"),
        CoffeeItem(name: "Latte"),
        CoffeeItem(name: "Cappuccino"),
        CoffeeItem(name: "Mocha"),
        CoffeeItem(name: "Americano"),
        CoffeeItem(name: "Flat White"),
        CoffeeItem(name: "Macchiato"),
        CoffeeItem(name: "Iced Coffee"),
        CoffeeItem(name: "Affogato"),
        CoffeeItem(name: "Cold Brew")
    ])
    .padding()
}

