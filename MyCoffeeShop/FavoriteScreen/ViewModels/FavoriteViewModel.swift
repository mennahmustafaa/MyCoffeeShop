import Foundation

class FavoriteViewModel: ObservableObject {
    @Published private(set) var favorites: [ProductDetailItem] = [] {
        didSet { saveFavorites() }
    }

    private let favoritesKey = "favorites_key"

    init() {
        loadFavorites()
    }

    func toggleFavorite(for product: ProductDetailItem) {
        if isFavorite(product) {
            favorites.removeAll { $0.id == product.id }
        } else {
            favorites.append(product)
        }
    }

    func isFavorite(_ product: ProductDetailItem) -> Bool {
        favorites.contains { $0.id == product.id }
    }

    // MARK: - Persistence
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([ProductDetailItem].self, from: data) {
            favorites = decoded
        }
    }
}

