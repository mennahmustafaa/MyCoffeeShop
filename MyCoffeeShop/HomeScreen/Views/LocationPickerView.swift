import SwiftUI

struct LocationPickerView: View {
    let currentLocation: Location
    let availableLocations: [Location]
    let onLocationSelected: (Location) -> Void
    @Binding var isPresented: Bool

    @StateObject private var locationService = CurrentLocationService()
    @State private var searchText = ""

    var filteredLocations: [Location] {
        if searchText.isEmpty {
            return availableLocations
        } else {
            return availableLocations.filter {
                $0.displayName.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(.gray)
                    TextField("Search location", text: $searchText).font(.system(size: 15))
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                        }
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()

                Button(action: {
                    locationService.detectCurrentLocation {
                        // Handle detected location
                    }
                }) {
                    HStack {
                        if locationService.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(0.8)
                        } else {
                            Image(systemName: "location.fill")
                                .foregroundColor(Color("PrimaryColor"))
                        }
                        Text(locationService.isLoading ? "Detecting location..." : "Use current location")
                            .foregroundColor(Color("PrimaryColor"))
                            .font(.system(size: 15, weight: .medium))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }

                List {
                    Section(header: Text("Choose your location")) {
                        ForEach(filteredLocations) { location in
                            Button(action: {
                                onLocationSelected(location)
                                isPresented = false
                            }) {
                                HStack {
                                    Text(location.displayName)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    if location.id == currentLocation.id {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color("PrimaryColor"))
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Select Location")
            .navigationBarItems(trailing: Button("Close") { isPresented = false })
            .onAppear {
                locationService.requestPermission()
            }
        }
    }
}