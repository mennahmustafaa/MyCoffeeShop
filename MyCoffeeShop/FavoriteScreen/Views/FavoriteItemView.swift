import SwiftUI

struct FavoriteItemView: View {
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @Environment(\.dismiss) private var dismiss   // dismiss instead of new stack

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(favoriteVM.favorites) { product in
                    FavoriteViewRow(product: product)
                        .environmentObject(favoriteVM)
                        .environmentObject(cartVM)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 32)
        }
        .toolbar {
            // Custom title
            ToolbarItem(placement: .principal) {
                Text("Favorite")
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.14, green: 0.14, blue: 0.14))
                    .frame(width: 77, alignment: .top)
            }

            // Custom back button -> just dismiss
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true) // hide default
        .alert(isPresented: $cartVM.showAlert) {
            Alert(
                title: Text("Added to Cart! 🛒"),
                message: Text(cartVM.successMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    NavigationStack {
        FavoriteItemView()
            .environmentObject(FavoriteViewModel())
    }
}

