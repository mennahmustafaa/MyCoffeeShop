import Foundation
import Combine

class LocationViewModel: ObservableObject {
    @Published var currentLocation: Location
    @Published var availableLocations: [Location]

    init() {
        let locations = [
            Location(city: "Bilzen", area: "Tanjungbalai"),
            Location(city: "Jakarta", area: "Kemang"),
            Location(city: "Surabaya", area: "City Center"),
            Location(city: "Bandung", area: "Dago"),
            Location(city: "Bali", area: "Seminyak")
        ]

        self.availableLocations = locations
        self.currentLocation = locations[0]
    }

    func updateLocation(_ location: Location) {
        currentLocation = location
    }
}