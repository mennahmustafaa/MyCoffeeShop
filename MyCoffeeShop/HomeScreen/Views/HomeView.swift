import SwiftUI

struct HomeView: View {
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    @EnvironmentObject var appState: AppState

    @StateObject private var locationViewModel = LocationViewModel()
    @StateObject private var coffeeViewModel = CoffeeListViewModel()
    @StateObject private var bottomBarViewModel = ToolbarViewModel()
    
    @State private var showLocationPicker = false
    @State private var selectedProduct: CoffeeItem? = nil
    @State private var showFavorites = false
    @State private var showCart = false
    @State private var showNotifications = false
    @State private var showHeader = false
    @State private var showBanner = false
    @State private var showContent = false

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
                                HStack {
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
                                
                                Spacer()
                                
                                // Logout Button
                                Button {
                                    appState.signOut()
                                } label: {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 10)
                            }
                            .offset(y: 25)
                            .opacity(showHeader ? 1 : 0)
                            .offset(y: showHeader ? 0 : -20)
                                
                                VStack {
                                    Image("Banner")
                                        .resizable()
                                        .frame(width: 327, height: 160)
                                        .cornerRadius(12)
                                        .padding(.top, 20)
                                        .offset(x: 20, y: 90)
                                        .opacity(showBanner ? 1 : 0)
                                        .scaleEffect(showBanner ? 1 : 0.9)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Main content
                        VStack(spacing: 16) {
                            VStack(alignment: .leading) {
                                SearchView(viewModel: coffeeViewModel)
                                    .offset(x: -25, y: -200)
                                    .opacity(showContent ? 1 : 0)
                            }
                            
                            MenuBarView(viewModel: coffeeViewModel)
                                .opacity(showContent ? 1 : 0)
                            
                            CoffeeGridView(
                                viewModel: coffeeViewModel,
                                onProductTap: { tappedProduct in
                                    selectedProduct = tappedProduct
                                },
                                onAddToCart: { coffeeItem in
                                    // Add to cart with default size M
                                    cartVM.addToCart(product: coffeeItem.asProductDetail, size: "M")
                                }
                            )
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
                            } else if bottomBarViewModel.selectedTab == "notifications" {
                                showNotifications = true
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
                        .onChange(of: showNotifications) {
                            if !showNotifications {
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
            // Navigation for notifications
            .navigationDestination(isPresented: $showNotifications) {
                NotificationsView()
            }
        }
        .onAppear {
            // Staggered animations for different sections
            withAnimation(.easeOut(duration: 0.5)) {
                showHeader = true
            }
            
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2)) {
                showBanner = true
            }
            
            withAnimation(.easeOut(duration: 0.5).delay(0.3)) {
                showContent = true
            }
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

#Preview {
    let favoriteVM = FavoriteViewModel()
    let cartVM = CartViewModel()
    
    return HomeView()
        .environmentObject(favoriteVM)
        .environmentObject(cartVM)
        .environmentObject(AppState())
}

