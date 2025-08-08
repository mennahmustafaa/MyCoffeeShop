//
//  ChangePaaword.swift
//  MyCoffeeShop
//
//  Created by Mennah on 25/07/2025.
//
import Foundation
import FirebaseAuth

@MainActor
class ChangePasswordViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var successMessage: String?

    func changePassword(to newPassword: String) {
        guard let user = Auth.auth().currentUser else {
            errorMessage = "No user is currently logged in."
            return
        }

        Task {
            do {
                try await user.updatePassword(to: newPassword)
                successMessage = "Password updated successfully."
                errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
                successMessage = nil
            }
        }
    }
}

