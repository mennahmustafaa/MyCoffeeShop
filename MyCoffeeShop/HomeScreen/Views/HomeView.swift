import SwiftUI

struct HomeView: View {
    @StateObject private var locationViewModel = LocationViewModel()
    @StateObject private var coffeeViewModel = CoffeeListViewModel()
    @StateObject private var bottomBarViewModel = ToolbarViewModel()
    @State private var showLocationPicker = false

    init() {
        print("\u{1F3C1} HomeView init started")
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    Color.black
                        .frame(height: 300)
                        .ignoresSafeArea(edges: .top)
                        .offset(y: -65)
                        .onAppear { print("\u{1F7E2} Color background loaded") }

                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 2) {
                            
                            Text("Location")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .onAppear { print("\u{1F4CD} Location label appeared") }

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
                            .onAppear { print("\u{1F7E2} Location picker button loaded") }
                            
                        }
                        .offset(y:25)

                        VStack {
                            Image("Banner")
                                .resizable()
                                .frame(width: 327, height: 160)
                                .cornerRadius(12)
                                .padding(.top, 20)
                                .onAppear { print("\u{1F5BC} Banner image appeared") }
                                .offset(x:12,y:120)
                        }
                    }
                   // .padding(.top, 60)
                    .padding(.horizontal)
                }

                VStack(spacing: 16) {
                    VStack(alignment:.leading) {
                        SearchView(viewModel: coffeeViewModel)
                            .onAppear { print("\u{1F50D} SearchView loaded") }
                            .offset(x:-25,y:-200)
                    }

                    VStack {
                        MenuBarView(viewModel: coffeeViewModel)
                            .onAppear { print("\u{1F4CB} MenuBarView loaded") }
                    }

                    VStack {
                        CoffeeGridView(viewModel: coffeeViewModel)
                    }
                }

            }
            
            VStack {
                BottomToolbarView(viewModel: bottomBarViewModel)
                    .padding(.bottom, 10)
                    .background(Color.white.ignoresSafeArea(edges: .bottom))
                    .onAppear { print("🛠️ BottomToolbarView loaded") }
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
            .onAppear { print("\u{1F4CD} LocationPickerView presented") }
        }
        .onAppear {
            print("\u{1F3E0} HomeView appeared")
        }
    }
}

#Preview {
    HomeView()
}

