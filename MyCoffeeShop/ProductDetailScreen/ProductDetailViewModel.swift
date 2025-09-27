import SwiftUI
import Foundation
import Foundation

class ProductListViewModel: ObservableObject {
    @Published var products: [ProductDetailItem] = []

    init() {
        loadProducts()
    }

    private func loadProducts() {
        products = [
            ProductDetailItem(
                id: 1,
                name: "Caffe Mocha",
                type: "Hot",
                description: "A delicious blend of rich chocolate syrup, bold espresso, and velvety steamed milk, topped with a smooth foam layer.",
                price: 4.53,
                imageName: "mocha"
            ),
            ProductDetailItem(
                id: 2,
                name: "Flat White",
                type: "Hot",
                description: "An espresso-forward drink with a silky texture, combining smooth microfoam and rich espresso.",
                price: 3.53,
                imageName: "flatwhite"
            ),
            ProductDetailItem(
                id: 3,
                name: "Latte",
                type: "Hot",
                description: "A comforting cup made with espresso and steamed milk, finished with a light foam.",
                price: 3.99,
                imageName: "latte"
            ),
            ProductDetailItem(
                id: 4,
                name: "Cappuccino",
                type: "Hot",
                description: "Bold espresso layered with steamed milk and a thick cap of airy foam.",
                price: 4.20,
                imageName: "cappuccino"
            ),
            ProductDetailItem(
                id: 5,
                name: "Caramel Macchiato",
                type: "Sweet",
                description: "Vanilla syrup, steamed milk, and espresso, finished with buttery caramel drizzle.",
                price: 4.75,
                imageName: "caramelmacchiato"
            ),
            ProductDetailItem(
                id: 6,
                name: "Iced Matcha",
                type: "Iced",
                description: "Refreshing Japanese matcha green tea shaken with milk and ice.",
                price: 4.10,
                imageName: "matcha"
            )
        ]
    }
}
