import Foundation

class CartViewModel: ObservableObject {
    @Published private(set) var cartItems: [CartItem] = []
    @Published var successMessage: String? = nil
    @Published var showAlert: Bool = false

    var totalPrice: Double {
        cartItems.reduce(0) { $0 + ($1.adjustedPrice * Double($1.quantity)) }
    }

    func addToCart(product: ProductDetailItem, size: String) {
        if let index = cartItems.firstIndex(where: { $0.product == product && $0.size == size }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(product: product, size: size))
        }
        successMessage = "\(product.name) added to cart 🎉"
        showAlert = true
    }

    func increaseQuantity(for item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index].quantity += 1
        }
    }

    func decreaseQuantity(for item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            if cartItems[index].quantity > 1 {
                cartItems[index].quantity -= 1
            } else {
                cartItems.remove(at: index)
            }
        }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}

