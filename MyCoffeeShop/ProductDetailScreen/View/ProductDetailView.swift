import SwiftUI

struct ProductDetailView: View {
    let product: ProductDetailItem
    @State private var selectedSize: String = "M"
    @State private var isExpanded: Bool = false
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding()
                }

                Spacer()
                Text("Detail")
                    .font(.headline)
                Spacer()

                Button(action: { favoriteVM.toggleFavorite(for: product) }) {
                    Image(systemName: favoriteVM.isFavorite(product) ? "heart.fill" : "heart")
                        .foregroundColor(favoriteVM.isFavorite(product) ? .red : .black)
                        .padding()
                }
            }
            .padding(.horizontal)

            // Image
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 327, height: 202)
                .cornerRadius(16)
                .offset(x: 32)

            // Title & Type
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.title2).bold()
                Text(product.type)
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            .padding(.horizontal)

            Divider()

            // Description
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.headline)
                Text(isExpanded ? product.description :
                     String(product.description.prefix(120)) + "…")
                    .foregroundColor(.gray)
                    .font(.subheadline)

                Button(action: { isExpanded.toggle() }) {
                    Text(isExpanded ? "Read Less" : "Read More")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal)

            // Size Picker
            VStack(alignment: .leading, spacing: 16) {
                Text("Size")
                    .font(.headline)

                HStack {
                    ForEach(["S", "M", "L"], id: \.self) { size in
                        Button(action: { selectedSize = size }) {
                            Text(size)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedSize == size ? Color.orange.opacity(0.2) : Color(.systemGray6))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedSize == size ? Color.orange : Color.clear, lineWidth: 1.5)
                                )
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()

            // Price + Add to Cart
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Price")
                        .foregroundColor(.gray)
                    Text("$ \(String(format: "%.2f", product.price))")
                        .font(.title3).bold()
                        .foregroundColor(.brown)
                        .offset(y: -4)
                }

                Spacer()

                Button(action: {
                    cartVM.addToCart(product: product, size: selectedSize)
                }) {
                    Text("Add to Cart")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 217)
                        .background(Color.brown)
                        .cornerRadius(14)
                        .offset(x: -4)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            .offset(y: -20)
        }
        .navigationBarHidden(true)
    }
}


#Preview {
    let productVM = ProductListViewModel()
    let favoriteVM = FavoriteViewModel()
    let cartVM = CartViewModel()

    return NavigationStack {
        ProductDetailView(product: productVM.products[0])
            .environmentObject(favoriteVM)
            .environmentObject(cartVM)
    }
}

  
