import SwiftUI
import Foundation

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
}

struct AppView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            if appState.isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}

