import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct MyCoffeeShopApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // ✅ Shared view models
    @StateObject private var favoriteVM = FavoriteViewModel()
    @StateObject private var cartVM = CartViewModel()

    var body: some Scene {
        WindowGroup {
            OnboardingView() // 👈 your entry screen stays here
                .environmentObject(favoriteVM)
                .environmentObject(cartVM) // 👈 inject cartVM too
        }
    }
}

