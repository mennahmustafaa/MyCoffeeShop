import Foundation

struct Location: Identifiable, Hashable {
    let id = UUID()
    let city: String
    let area: String

    var displayName: String {
        "\(city), \(area)"
    }
}