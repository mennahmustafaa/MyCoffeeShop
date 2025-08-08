import SwiftUI

struct ProductDetailView: View {
    let product: ProductDetailItem
    @State private var selectedSize: String = "M"
    @State private var isExpanded: Bool = false
    @State private var navigateToHome = false
    @Environment(\.dismiss) var dismiss
    // Alternative for iOS 15 and earlier:
    // @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with back and favorite icons
            HStack {
                Button(action: {
                    print("Back button tapped") // Debug line
                    navigateToHome = true // Trigger navigation to HomeView
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.clear)
                }

                Spacer()

                Text("Detail")
                    .font(.headline)

                Spacer()

                Button(action: {
                    // Handle favorite
                }) {
                    Image(systemName: "heart")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.clear)
                }
            }
            .padding(.horizontal)

            // Product image
            VStack(alignment: .leading, spacing: 16) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 327, height: 202)
                    .background(
                        Image(product.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    )
                    .cornerRadius(16)
                    .offset(x: 32)
            }

            // Title & Type
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.title2)
                    .fontWeight(.bold)

                // Icons
                HStack(spacing: 12) {
                    Text("Ice/Hot")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                        .padding(.vertical, 8)

                    Spacer()

                    Image(systemName: "bicycle")
                        .foregroundColor(Color(hex: "#C67C4E"))
                        .padding(8)
                        .background(Color(hex: "#F4F4F4"))
                        .cornerRadius(8)

                    Image(systemName: "leaf")
                        .foregroundColor(Color(hex: "#C67C4E"))
                        .padding(8)
                        .background(Color(hex: "#F4F4F4"))
                        .cornerRadius(8)

                    Image(systemName: "cup.and.saucer")
                        .foregroundColor(Color(hex: "#C67C4E"))
                        .padding(8)
                        .background(Color(hex: "#F4F4F4"))
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

            Divider()

            // Description with Read More
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.headline)

                Text(isExpanded ? product.description : String(product.description.prefix(120)) + "...")
                    .foregroundColor(.gray)
                    .font(.subheadline)

                Button(action: {
                    isExpanded.toggle()
                }) {
                    Text(isExpanded ? "Read Less" : "Read More")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal)

            // Size selection
            VStack(alignment: .leading, spacing: 16) {
                Text("Size")
                    .font(.headline)

                HStack {
                    ForEach(["S", "M", "L"], id: \.self) { size in
                        Button(action: {
                            selectedSize = size
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
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()

            // Price and Buy Now
            HStack(alignment: .center, spacing: 34) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Price")
                        .foregroundColor(.gray)

                    Text("$ \(String(format: "%.2f", product.price))")
                        .font(.title3)
                        .bold()
                        .foregroundColor(Color(hex: "#C67C4E"))
                        .offset(y: -4)
                }

                Spacer()

                Button(action: {
                    // Handle Buy Now
                }) {
                    Text("Buy Now")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 217)
                        .background(Color(hex: "#C67C4E"))
                        .cornerRadius(14)
                        .offset(x: -4)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            .offset(y: -20)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToHome) {
            HomeView()
        }
    }
}

#Preview {
    let viewModel = ProductListViewModel()
    if let firstProduct = viewModel.products.first {
        NavigationStack {
            ProductDetailView(product: firstProduct)
        }
    } else {
        Text("No product available")
    }
}
