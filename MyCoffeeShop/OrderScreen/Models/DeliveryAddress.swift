import Foundation
import CoreLocation

struct DeliveryAddress: Codable, Identifiable {
    let id: UUID
    var area: String
    var locationName: String
    var buildingName: String
    var apartmentNumber: String
    var floor: String
    var phoneNumber: String
    var latitude: Double
    var longitude: Double
    
    init(
        id: UUID = UUID(),
        area: String = "",
        locationName: String = "",
        buildingName: String = "",
        apartmentNumber: String = "",
        floor: String = "",
        phoneNumber: String = "",
        latitude: Double = 30.0444,   // default Cairo
        longitude: Double = 31.2357
    ) {
        self.id = id
        self.area = area
        self.locationName = locationName
        self.buildingName = buildingName
        self.apartmentNumber = apartmentNumber
        self.floor = floor
        self.phoneNumber = phoneNumber
        self.latitude = latitude
        self.longitude = longitude
    }
}

