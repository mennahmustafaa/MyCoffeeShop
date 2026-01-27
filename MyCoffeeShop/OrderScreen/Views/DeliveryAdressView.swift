//
//  NewAddressView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 30/09/2025.
//

import SwiftUI
import MapKit
import CoreLocation

struct NewAddressView: View {
    @StateObject private var viewModel = DeliveryAddressViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State private var cameraPosition: MapCameraPosition
    @State private var centerCoordinate: CLLocationCoordinate2D
    @State private var searchText = ""
    @State private var searchResults: [MKMapItem] = []
    @State private var isSearching = false
    
    init() {
        // Use default Cairo coordinates (will be updated from saved address in onAppear)
        let defaultCoordinate = CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357)
        let initialRegion = MKCoordinateRegion(
            center: defaultCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        _cameraPosition = State(initialValue: .region(initialRegion))
        _centerCoordinate = State(initialValue: defaultCoordinate)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search location...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .onChange(of: searchText) { _, newValue in
                        if !newValue.isEmpty {
                            searchLocation(query: newValue)
                        } else {
                            searchResults = []
                            isSearching = false
                        }
                    }
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                        searchResults = []
                        isSearching = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            // Search Results
            if isSearching && !searchResults.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(searchResults, id: \.self) { item in
                            Button {
                                selectSearchResult(item)
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name ?? "Unknown")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    if let address = item.placemark.title {
                                        Text(address)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .frame(maxHeight: 150)
            }
            
            // Map
            ZStack {
                Map(position: $cameraPosition) {
                    UserAnnotation()
                }
                .mapStyle(.hybrid(elevation: .realistic, showsTraffic: true))
                .frame(height: 200)
                .cornerRadius(12)
                .onMapCameraChange(frequency: .continuous) { context in
                    centerCoordinate = context.region.center
                    updateArea()
                }

                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.red)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
            }
            
            // Area
            HStack {
                Label("Area", systemImage: "mappin.circle.fill")
                Spacer()
                Text(viewModel.address.area)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            // Inputs
            Group {
                TextField("Location Name", text: $viewModel.address.locationName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Building Name", text: $viewModel.address.buildingName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    TextField("Apt. Number", text: $viewModel.address.apartmentNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Floor", text: $viewModel.address.floor)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                TextField("Phone Number", text: $viewModel.address.phoneNumber)
                    .keyboardType(.phonePad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Spacer()
            
            // Save Button
            Button(action: {
                // Update coordinates before saving
                viewModel.address.latitude = centerCoordinate.latitude
                viewModel.address.longitude = centerCoordinate.longitude
                viewModel.saveAddress()
                dismiss()
            }) {
                Text("Save Address")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.Colors.primaryBrown)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .navigationTitle("Edit Address")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Update camera position to saved address location
            let savedCoordinate = CLLocationCoordinate2D(
                latitude: viewModel.address.latitude,
                longitude: viewModel.address.longitude
            )
            centerCoordinate = savedCoordinate
            cameraPosition = .region(MKCoordinateRegion(
                center: savedCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ))
        }
    }
    
    private func updateArea() {
        let location = CLLocation(
            latitude: centerCoordinate.latitude,
            longitude: centerCoordinate.longitude
        )
        viewModel.updateArea(from: location)
    }
    
    private func searchLocation(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = MKCoordinateRegion(
            center: centerCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else { return }
            searchResults = response.mapItems
            isSearching = true
        }
    }
    
    private func selectSearchResult(_ item: MKMapItem) {
        let coordinate = item.placemark.coordinate
        centerCoordinate = coordinate
        cameraPosition = .region(MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
        
        // Update address fields from selected location
        if let name = item.name {
            viewModel.address.locationName = name
        }
        if let thoroughfare = item.placemark.thoroughfare {
            viewModel.address.buildingName = thoroughfare
        }
        
        searchText = ""
        searchResults = []
        isSearching = false
        updateArea()
    }
}

#Preview {
    NavigationView {
        NewAddressView()
    }
}
