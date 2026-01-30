import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var isAuthenticated = false
    
    init() {
        // Don't auto-check session on init - let the user login manually
    }
    
    func checkSession() {
        Task {
            do {
                if let _ = try await SupabaseService.shared.currentUser() {
                    await MainActor.run {
                        self.isAuthenticated = true
                    }
                }
            } catch {
                print("No session found or error: \(error)")
            }
        }
    }
    
    func signOut() {
        Task {
            do {
                try await SupabaseService.shared.signOut()
                await MainActor.run {
                    self.isAuthenticated = false
                }
            } catch {
                print("Sign out error: \(error)")
            }
        }
    }
}
