import Combine
import Foundation
class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var allItems: [CoffeeItem]

    // Custom initializer
    init(items: [CoffeeItem]) {
        self.allItems = items
    }

    var filteredItems: [CoffeeItem] {
        if searchText.isEmpty {
            return allItems
        } else {
            return allItems.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

