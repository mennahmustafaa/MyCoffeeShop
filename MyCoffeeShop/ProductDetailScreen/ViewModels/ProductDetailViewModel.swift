
import Foundation

class ProductDetailViewModel: ObservableObject {
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
                description: "A delicious blend of rich chocolate syrup, bold espresso, and velvety steamed milk, topped with a smooth foam layer. Perfect for chocolate lovers seeking a cozy kick.",
                price: 4.53,
                imageName: "mocha"
            ),
            ProductDetailItem(
                id: 2,
                name: "Flat White",
                type: "Hot",
                description: "An espresso-forward drink with a silky texture, created by combining smooth microfoam and rich espresso in perfect balance. Creamy and bold in every sip.",
                price: 3.53,
                imageName: "flatwhite"
            ),
            ProductDetailItem(
                id: 3,
                name: "Latte",
                type: "Hot",
                description: "A comforting cup made with a shot of espresso and steamed milk, finished with a light layer of foam. Mild, creamy, and endlessly customizable.",
                price: 3.99,
                imageName: "latte"
            ),
            ProductDetailItem(
                id: 4,
                name: "Cappuccino",
                type: "Hot",
                description: "A timeless classic — bold espresso layered with steamed milk and a thick cap of airy foam. Balanced, bold, and deliciously frothy.",
                price: 4.20,
                imageName: "cappuccino"
            ),
            ProductDetailItem(
                id: 5,
                name: "Caramel Macchiato",
                type: "Sweet",
                description: "An indulgent mix of vanilla syrup, steamed milk, and espresso, finished with buttery caramel drizzle. A layered drink with sweet and bold notes.",
                price: 4.75,
                imageName: "caramelmacchiato"
            ),
            ProductDetailItem(
                id: 6,
                name: "Iced Matcha",
                type: "Iced",
                description: "A refreshing drink made from fine Japanese matcha green tea, shaken with milk and ice for a cool, earthy, and energizing treat.",
                price: 4.10,
                imageName: "matcha"
            )
        ]
    }

    // For SwiftUI Previews
 
}
