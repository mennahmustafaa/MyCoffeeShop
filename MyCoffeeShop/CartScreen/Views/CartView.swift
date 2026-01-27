import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel
    @State private var navigateToOrder = false
    var rootPresenting: Binding<Bool>? // Optional binding for pop to root

    var body: some View {
        VStack {
            if cartVM.cartItems.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "cart")
                        .font(.system(size: 50))
                        .foregroundColor(.gray.opacity(0.6))
                    Text("Your cart is empty")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                Spacer()
            } else {
                List {
                    ForEach(cartVM.cartItems) { item in
                        HStack(spacing: 12) {
                            Image(item.product.imageName)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.product.name).bold()
                                HStack(spacing: 4) {
                                    Text(item.product.type)
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                    Text("•")
                                        .foregroundColor(.gray)
                                    Text("Size: \(item.size)")
                                        .foregroundColor(AppTheme.Colors.primaryBrown)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                                Text("$\(String(format: "%.2f", item.adjustedPrice))")
                                    .foregroundColor(.brown)
                                    .font(.subheadline)
                            }

                            Spacer()

                            HStack(spacing: 12) {
                                Button {
                                    cartVM.decreaseQuantity(for: item)
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(.brown)
                                }
                                .buttonStyle(.plain)

                                Text("\(item.quantity)")
                                    .frame(minWidth: 24)

                                Button {
                                    cartVM.increaseQuantity(for: item)
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(.brown)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(.insetGrouped)
            }

            // Bottom bar
            if !cartVM.cartItems.isEmpty {
                HStack {
                    Text("Total: $\(String(format: "%.2f", cartVM.totalPrice))")
                        .font(.headline)

                    Spacer()

                    Button("Checkout") {
                        navigateToOrder = true
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(AppTheme.Colors.primaryBrown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
        .navigationTitle("Cart")
        .navigationDestination(isPresented: $navigateToOrder) {
            OrderView(cartItems: cartVM.cartItems, rootPresenting: rootPresenting)
                .environmentObject(cartVM)
        }
        .alert(isPresented: $cartVM.showAlert) {
            Alert(
                title: Text("Added to Cart! 🛒"),
                message: Text(cartVM.successMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// MARK: - Preview with injected mock items
#Preview("CartView") {
    let cartVM = CartViewModel()
    let favVM = FavoriteViewModel()

    // Inject some fake products into the cart for preview
    let mockProducts = [
        ProductDetailItem(id: 1, name: "Caffe Mocha", type: "Hot", description: "", price: 4.53, imageName: "mocha"),
        ProductDetailItem(id: 2, name: "Iced Matcha", type: "Iced", description: "", price: 4.10, imageName: "matcha")
    ]
    cartVM.addToCart(product: mockProducts[0], size: "M")
    cartVM.addToCart(product: mockProducts[1], size: "L")
    cartVM.addToCart(product: mockProducts[1], size: "L") // add again to test quantity

    return NavigationStack {
        CartView()
            .environmentObject(cartVM)
            .environmentObject(favVM)
    }
}
