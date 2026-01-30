import Foundation
import CoreLocation
import MapKit

class DeliveryAddressViewModel: ObservableObject {
    @Published var address: DeliveryAddress
    private let storageKey = "savedDeliveryAddress"
    private let geocoder = CLGeocoder()
    
    init() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let saved = try? JSONDecoder().decode(DeliveryAddress.self, from: data) {
            self.address = saved
        } else {
            self.address = DeliveryAddress(area: "Cairo")
        }
    }
    
    func saveAddress() {
        if let data = try? JSONEncoder().encode(address) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    func updateArea(from location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, _ in
            guard let self = self else { return }
            if let place = placemarks?.first {
                DispatchQueue.main.async {
                    self.address.area = place.subLocality ??
                    place.locality ??
                    place.name ??
                    "Unknown Area"
                    self.address.latitude = location.coordinate.latitude
                    self.address.longitude = location.coordinate.longitude
                }
            }
        }
    }
}

