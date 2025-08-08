import Foundation
import FirebaseAuth

@MainActor
class LoginViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var loginErrorMessage: String?

    func login(email: String, password: String) {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedEmail.isEmpty, !trimmedPassword.isEmpty else {
            loginErrorMessage = "Please enter both email and password."
            return
        }

        Task {
            do {
                let user = try await AuthenticationManager.shared.signIn(
                    email: trimmedEmail,
                    password: trimmedPassword
                )
                self.isLoggedIn = true

                print("✅ Logged in as: \(user.uid)")
                self.loginErrorMessage = nil
                self.isLoggedIn = true
            } catch {
                print("❌ Firebase Login Error: \(error.localizedDescription)")
                self.loginErrorMessage = self.mapFirebaseError(error)
                self.isLoggedIn = false
            }
        }
    }

    private func mapFirebaseError(_ error: Error) -> String {
        let nsError = error as NSError
        let errorCode = AuthErrorCode(rawValue: nsError.code)

        switch errorCode {
        case .invalidEmail:
            return "The email address is badly formatted."
        case .wrongPassword:
            return "Incorrect password. Please try again."
        case .userNotFound:
            return "No user found with this email."
        case .networkError:
            return "Network error. Please check your connection."
        case .tooManyRequests:
            return "Too many login attempts. Try again later."
        case .userDisabled:
            return "This account has been disabled."
        default:
            return "Login failed. Please try again."
        }
    }
}


