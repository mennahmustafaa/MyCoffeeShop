import SwiftUI

struct ProductDetailView: View {
    let product: ProductDetailItem
    @State private var selectedSize: String = "M"
    @State private var isExpanded: Bool = false
    @State private var navigateToHome = false
    @State private var showContent = false
    @State private var favoritePressed = false
    @State private var addToCartPressed = false

    @EnvironmentObject var favoriteVM: FavoriteViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @Environment(\.dismiss) private var dismiss
    
    var computedPrice: Double {
        switch selectedSize {
        case "S": return product.price
        case "M": return product.price + 1.0
        case "L": return product.price + 2.0
        default: return product.price
        }
    }
    
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
                
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                        favoritePressed = true
                    }
                    
                    let impact = UIImpactFeedbackGenerator(style: .medium)
                    impact.impactOccurred()
                    
                    favoriteVM.toggleFavorite(for: product)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                            favoritePressed = false
                        }
                    }
                }) {
                    Image(systemName: favoriteVM.isFavorite(product) ? "heart.fill" : "heart")
                        .foregroundColor(favoriteVM.isFavorite(product) ? .red : .black)
                        .padding()
                        .scaleEffect(favoritePressed ? 1.3 : 1.0)
                        .rotationEffect(.degrees(favoritePressed ? 15 : 0))
                }
            }
            .padding(.horizontal)
            
            // Product Image
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 327, height: 202)
                .cornerRadius(16)
                .offset(x: 32)
                .scaleEffect(showContent ? 1 : 0.9)
                .opacity(showContent ? 1 : 0)
            
            // Title & Type
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.title2).bold()
                Text(product.type)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                // Icons
                HStack(spacing: 12) {
                    Text("Ice/Hot")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                        .padding(.vertical, 8)
                    
                    Spacer()
                    
                    Image(systemName: "bicycle")
                        .foregroundColor(AppTheme.Colors.primaryBrown)
                        .padding(8)
                        .background(AppTheme.Colors.lightGray)
                        .cornerRadius(8)
                    
                    Image(systemName: "leaf")
                        .foregroundColor(AppTheme.Colors.primaryBrown)
                        .padding(8)
                        .background(AppTheme.Colors.lightGray)
                        .cornerRadius(8)
                    
                    Image(systemName: "cup.and.saucer")
                        .foregroundColor(AppTheme.Colors.primaryBrown)
                        .padding(8)
                        .background(AppTheme.Colors.lightGray)
                        .cornerRadius(8)
                }
                
                // Rating
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                    
                        .foregroundColor(.yellow)
                        .frame(width: 20, height: 20)
                    Text("4.8")
                    Text("(230)")
                        .foregroundColor(.gray)
                }
                .font(.subheadline)
                .padding(.top, 4)
            }
            .padding(.horizontal)
            .opacity(showContent ? 1 : 0)
            .offset(x: showContent ? 0 : -20)
            
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
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedSize = size
                            }
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                        }) {
                            Text(size)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedSize == size ? Color.orange.opacity(0.2) : Color(.systemGray6))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedSize == size ? Color.orange : Color.clear, lineWidth: 1.5)
                                )
                                .scaleEffect(selectedSize == size ? 1.05 : 1.0)
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Price + Add to Cart
            HStack(alignment: .center, spacing: 34) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Price")
                        .foregroundColor(.gray)
                    
                    Text("$ \(String(format: "%.2f", computedPrice))")
                        .font(.title3)
                        .bold()
                        .foregroundColor(AppTheme.Colors.primaryBrown)
                        .offset(y: -4)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                        addToCartPressed = true
                    }
                    
                    let impact = UIImpactFeedbackGenerator(style: .medium)
                    impact.impactOccurred()
                    
                    cartVM.addToCart(product: product, size: selectedSize)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            addToCartPressed = false
                        }
                    }
                }) {
                    Text("Add to Cart")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 217)
                        .background(Color.brown)
                        .cornerRadius(14)
                        .scaleEffect(addToCartPressed ? 0.95 : 1.0)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToHome) {
            HomeView()
        }
        .alert(isPresented: $cartVM.showAlert) {
            Alert(
                title: Text("Added to Cart! 🛒"),
                message: Text(cartVM.successMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                showContent = true
            }
        }
    }
}

#Preview {
    let productVM = ProductDetailViewModel()
    let favoriteVM = FavoriteViewModel()
    let cartVM = CartViewModel()
    
    return NavigationStack {
        ProductDetailView(product: productVM.products[0])
            .environmentObject(favoriteVM)
            .environmentObject(cartVM)
    }
}

