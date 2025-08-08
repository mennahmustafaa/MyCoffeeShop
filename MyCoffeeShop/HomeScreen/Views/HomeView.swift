import SwiftUI

struct HomeView: View {
    @StateObject private var locationViewModel = LocationViewModel()
    @StateObject private var coffeeViewModel = CoffeeListViewModel()
    @StateObject private var bottomBarViewModel = ToolbarViewModel()
    
    @State private var showLocationPicker = false
    @State private var selectedProduct: CoffeeItem? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                // Main scrollable content
                ScrollView {
                    VStack(spacing: 0) {
                        // Header section
                        ZStack(alignment: .topLeading) {
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: 410, height: 280)
                              .background(
                                LinearGradient(
                                  stops: [
                                    Gradient.Stop(color: Color(red: 0.07, green: 0.07, blue: 0.07), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.19, green: 0.19, blue: 0.19), location: 1.00),
                                  ],
                                  startPoint: UnitPoint(x: 1, y: 0),
                                  endPoint: UnitPoint(x: 0, y: 1)
                                )
                              )
                                .ignoresSafeArea(edges: .top)
                                .offset(y: -65)
                            
                            VStack(alignment: .leading) {
                                // Location picker
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Location")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Button(action: {
                                        showLocationPicker = true
                                    }) {
                                        HStack(spacing: 4) {
                                            Text(locationViewModel.currentLocation.displayName)
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.gray)
                                            
                                            Image(systemName: "chevron.down")
                                                .font(.caption2)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                .offset(y: 25)
                                
                                // Banner
                                VStack {
                                    Image("Banner")
                                        .resizable()
                                        .frame(width: 327, height: 160)
                                        .cornerRadius(12)
                                        .padding(.top, 20)
                                        .offset(x: 20, y: 90)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Main content
                        VStack(spacing: 16) {
                            VStack(alignment: .leading) {
                                SearchView(viewModel: coffeeViewModel)
                                    .offset(x: -25, y: -200)
                            }
                            
                            MenuBarView(viewModel: coffeeViewModel)
                            
                            CoffeeGridView(viewModel: coffeeViewModel) { tappedProduct in
                                selectedProduct = tappedProduct
                            }
                            .padding(.bottom, 100) // Space for bottom toolbar
                        }
                    }
                }
                
                // Fixed bottom toolbar
                VStack {
                    Spacer()
                    BottomToolbarView(viewModel: bottomBarViewModel)
                        .background(Color.white.ignoresSafeArea(edges: .bottom))
                }
            }
            // Location picker sheet
            .sheet(isPresented: $showLocationPicker) {
                LocationPickerView(
                    currentLocation: locationViewModel.currentLocation,
                    availableLocations: locationViewModel.availableLocations,
                    onLocationSelected: { location in
                        locationViewModel.updateLocation(location)
                    },
                    isPresented: $showLocationPicker
                )
            }
            // Navigation to detail
            .navigationDestination(item: $selectedProduct) { coffeeItem in
                ProductDetailView(product: coffeeItem.asProductDetail)
            }
        }
        .onAppear {
            print("🏠 HomeView appeared")
        }
    }
}

#Preview {
    HomeView()
}
