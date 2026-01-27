//
//  DeliveryTrackingViewModel.swift
//  MyCoffeeShop
//
//  Created by Mennah on 04/12/2025.
//

import SwiftUI
import MapKit
import CoreLocation

class DeliveryTrackingViewModel: ObservableObject {
    @Published var deliveryAddress: DeliveryAddress
    @Published var courierLocation: CLLocationCoordinate2D
    @Published var deliveryStatus: String = "10 minutes left"
    @Published var progress: Double = 0.75 // 3 out of 4 bars
    @Published var courierName: String = "Brooklyn Simmons"
    @Published var courierRole: String = "Personal Courier"
    @Published var courierImageName: String = "courier_avatar" // Placeholder
    
    @Published var route: MKRoute?
    
    // Mock store location in Nasr City, Cairo
    let storeLocation = CLLocationCoordinate2D(latitude: 30.0561, longitude: 31.3301)
    
    init(address: DeliveryAddress) {
        self.deliveryAddress = address
        // Start courier at store location
        self.courierLocation = storeLocation
        
        calculateRoute()
    }
    
    func calculateRoute() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: storeLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: deliveryAddress.latitude, longitude: deliveryAddress.longitude)))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self, let route = response?.routes.first else { return }
            DispatchQueue.main.async {
                self.route = route
            }
        }
    }
    
    var formattedAddress: String {
        return "\(deliveryAddress.buildingName), \(deliveryAddress.locationName)"
    }
    
    // Calculate region to show both store and user
    var region: MKCoordinateRegion {
        let userLoc = CLLocationCoordinate2D(latitude: deliveryAddress.latitude, longitude: deliveryAddress.longitude)
        
        let centerLat = (userLoc.latitude + storeLocation.latitude) / 2
        let centerLon = (userLoc.longitude + storeLocation.longitude) / 2
        let center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
        
        let latDelta = abs(userLoc.latitude - storeLocation.latitude) * 1.5
        let lonDelta = abs(userLoc.longitude - storeLocation.longitude) * 1.5
        
        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: max(latDelta, 0.01), longitudeDelta: max(lonDelta, 0.01))
        )
    }
}
