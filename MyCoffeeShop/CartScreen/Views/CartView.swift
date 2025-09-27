import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        VStack {
            if cartVM.cartItems.isEmpty {
                Text("Your cart is empty")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(cartVM.cartItems) { item in
                        HStack {
                            Image(item.product.imageName)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)

                            VStack(alignment: .leading) {
                                Text(item.product.name).bold()
                                Text(item.product.type)
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                Text("$ \(String(format: "%.2f", item.product.price))")
                                    .foregroundColor(.brown)
                            }

                            Spacer()

                            HStack(spacing: 12) {
                                Button(action: {
                                    cartVM.decreaseQuantity(for: item)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(.brown)
                                }
                                .buttonStyle(.plain)

                                Text("\(item.quantity)")
                                    .frame(minWidth: 24)

                                Button(action: {
                                    cartVM.increaseQuantity(for: item)
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(.brown)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 8)
                        .listRowSeparator(.visible)
                    }
                }
                .listStyle(.insetGrouped)
            }

            // Bottom bar
            HStack {
                Text("Total: $\(String(format: "%.2f", cartVM.totalPrice))")
                    .font(.headline)

                Spacer()

                Button("Checkout") {
                    // handle checkout
                }
                .padding()
                .background(Color.brown)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Cart")
        .alert(isPresented: $cartVM.showAlert) {
            Alert(
                title: Text("Success"),
                message: Text(cartVM.successMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview("CartView") {
    let cartVM = CartViewModel()
    return NavigationStack {
        CartView()
            .environmentObject(cartVM)
    }
}

