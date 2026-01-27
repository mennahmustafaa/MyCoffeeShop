import SwiftUI

struct HomeView: View {
    @EnvironmentObject var cartVM: CartViewModel       // 👈 shared cart
    @EnvironmentObject var favoriteVM: FavoriteViewModel  // 👈 shared favorites

    @StateObject private var locationViewModel = LocationViewModel()
    @StateObject private var coffeeViewModel = CoffeeListViewModel()
    @StateObject private var bottomBarViewModel = ToolbarViewModel()
    
    @State private var showLocationPicker = false
    @State private var selectedProduct: CoffeeItem? = nil
    @State private var showFavorites = false
    @State private var showCart = false   // 👈 add cart state

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
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
                                .offset(y: -70)
                            
                            VStack(alignment: .leading) {
                                // Location picker
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Location")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Button {
                                        showLocationPicker = true
                                    } label: {
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
                            .padding(.bottom, 100)
                        }
                    }
                }
                
                // Bottom toolbar
                VStack {
                    Spacer()
                    BottomToolbarView(viewModel: bottomBarViewModel)
                        .background(Color.white.ignoresSafeArea(edges: .bottom))
                        .onChange(of: bottomBarViewModel.selectedTab) {
                            if bottomBarViewModel.selectedTab == "favorites" {
                                showFavorites = true
                            } else if bottomBarViewModel.selectedTab == "cart" {
                                showCart = true
                            }
                        }
                        .onChange(of: showFavorites) {
                            if !showFavorites {
                                bottomBarViewModel.selectedTab = "home"
                            }
                        }
                        .onChange(of: showCart) {
                            if !showCart {
                                bottomBarViewModel.selectedTab = "home"
                            }
                        }

                }
            }
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
            // Navigation for selected product
            .navigationDestination(item: $selectedProduct) { coffeeItem in
                ProductDetailView(product: coffeeItem.asProductDetail)
                    .environmentObject(cartVM)
                    .environmentObject(favoriteVM)
            }
            // Navigation for favorites
            .navigationDestination(isPresented: $showFavorites) {
                FavoriteItemView()
                    .environmentObject(favoriteVM)
            }
            // Navigation for cart
            .navigationDestination(isPresented: $showCart) {
                CartView(rootPresenting: $showCart)
                    .environmentObject(cartVM)
            }
        }
    }
}

#Preview {
    let favoriteVM = FavoriteViewModel()
    let cartVM = CartViewModel()
    
    return HomeView()
        .environmentObject(favoriteVM)
        .environmentObject(cartVM)
}

