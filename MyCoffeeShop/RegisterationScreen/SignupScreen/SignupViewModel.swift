//
//  SignupViewModel.swift
//  MyCoffeeShop
//
//  Created by Mennah on 21/07/2025.
//

//
//  SignupViewModel 2.swift
//  MyCoffeeShop
//
//  Created by Mennah on 22/07/2025.
//


import Foundation
import FirebaseAuth

@MainActor
class SignupViewModel: ObservableObject {
    @Published var isSignedUp = false
    @Published var signupErrorMessage: String?

    func signup(name: String, email: String, password: String, confirmPassword: String) {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            signupErrorMessage = "All fields are required."
            return
        }

        guard password == confirmPassword else {
            signupErrorMessage = "Passwords do not match."
            return
        }

        Task {
            do {
                let user = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("✅ Signed up as: \(user.uid)")

                // Optional: update display name
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                try await changeRequest?.commitChanges()

                self.isSignedUp = true
            } catch {
                self.signupErrorMessage = mapFirebaseError(error)
            }
        }
    }

    private func mapFirebaseError(_ error: Error) -> String {
        let nsError = error as NSError
        let code = AuthErrorCode(rawValue: nsError.code)

        switch code {
        case .emailAlreadyInUse:
            return "This email is already registered."
        case .invalidEmail:
            return "The email address is badly formatted."
        case .weakPassword:
            return "The password must be 6 characters or more."
        case .networkError:
            return "Network error. Please try again."
        default:
            return "Signup failed. Please try again."
        }
    }
}
