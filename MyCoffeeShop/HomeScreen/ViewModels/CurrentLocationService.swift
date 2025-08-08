import Foundation

class CurrentLocationService: ObservableObject {
    @Published var isLoading = false

    func requestPermission() {
        // Add location permission logic here
    }

    func detectCurrentLocation(completion: @escaping () -> Void) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            completion()
        }
    }
}