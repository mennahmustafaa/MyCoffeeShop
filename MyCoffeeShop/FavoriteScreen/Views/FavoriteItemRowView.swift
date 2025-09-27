import SwiftUI

struct FavoriteViewRow: View {
    let product: ProductDetailItem
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    // 👉 You’ll need a CartViewModel if you want to manage a real cart
    // @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        HStack {
            Image(product.imageName)
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .bold()
                Text(product.type)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Heart button
            Button(action: {
                favoriteVM.toggleFavorite(for: product)
            }) {
                Image(systemName: favoriteVM.isFavorite(product) ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(favoriteVM.isFavorite(product) ? .red : .gray)
                    .padding(6)
                    .frame(width: 28, height: 28)
            }
            .buttonStyle(PlainButtonStyle())

            // Plus button → Add to cart
            Button(action: {
                print("➕ Added \(product.name) to cart")
                // cartVM.addToCart(product)
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundColor(.black)
                    .padding(6)
                    .frame(width: 28, height: 28)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(Color(red: 0.98, green: 0.95, blue: 0.93))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(Color(red: 0.93, green: 0.84, blue: 0.78), lineWidth: 1)
        )
    }
}

#Preview {
    let productVM = ProductListViewModel()
    let favoriteVM = FavoriteViewModel()
    favoriteVM.toggleFavorite(for: productVM.products[0])
    return FavoriteViewRow(product: productVM.products[0])
        .environmentObject(favoriteVM)
}

