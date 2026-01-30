import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var name = ""
    @Published var phoneNumber = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    @Published var shouldNavigate = false
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var debugMessage = ""
    
    init() {}
    
    func signIn() {
        debugMessage += "\nSignIn called"
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password."
            showAlert = true
            alertMessage = "Please enter email and password."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            debugMessage += "\nSignIn Task started"
            do {
                try await SupabaseService.shared.signIn(email: email, password: password)
                debugMessage += "\nSignIn success"
                await MainActor.run {
                    self.isLoading = false
                    self.alertMessage = "Login Successful! Welcome back!"
                    self.showAlert = true
                    self.shouldNavigate = true
                    self.isAuthenticated = true
                }
            } catch {
                debugMessage += "\nSignIn error: \(error)"
                await MainActor.run {
                    self.isLoading = false
                    // Check for invalid credentials
                    let errorString = error.localizedDescription.lowercased()
                    if errorString.contains("invalid") || errorString.contains("credentials") || errorString.contains("password") || errorString.contains("not found") {
                        self.errorMessage = "Invalid email or password."
                        self.alertMessage = "Login Failed\n\nThe email or password you entered is incorrect. Please try again."
                    } else {
                        self.errorMessage = error.localizedDescription
                        self.alertMessage = "Login Failed: \(error.localizedDescription)"
                    }
                    self.showAlert = true
                }
            }
        }
    }
    
    func signUp() {
        debugMessage += "\nSignUp called with email: \(email)"
        
        guard !email.isEmpty, !password.isEmpty, !name.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Please fill in all fields."
            showAlert = true
            alertMessage = "Please fill in all fields."
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            showAlert = true
            alertMessage = "Passwords do not match."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            debugMessage += "\nSignUp Task started"
            do {
                try await SupabaseService.shared.signUp(email: email, password: password)
                debugMessage += "\nSignUp success"
                
                // Auto sign-in after successful signup (no email confirmation required)
                try await SupabaseService.shared.signIn(email: email, password: password)
                debugMessage += "\nAuto sign-in success"
                
                await MainActor.run {
                    self.isLoading = false
                    self.alertMessage = "Account created successfully! Welcome!"
                    self.showAlert = true
                    self.isAuthenticated = true
                }
            } catch {
                debugMessage += "\nSignUp error: \(error)"
                await MainActor.run {
                    self.isLoading = false
                    // Check if user already exists
                    let errorString = error.localizedDescription.lowercased()
                    if errorString.contains("already registered") || errorString.contains("already exists") || errorString.contains("user already") {
                        self.errorMessage = "This email is already registered."
                        self.alertMessage = "Account Already Exists\n\nThis email is already registered. Please login instead."
                    } else {
                        self.errorMessage = error.localizedDescription
                        self.alertMessage = "Sign Up Failed: \(error.localizedDescription)"
                    }
                    self.showAlert = true
                }
            }
        }
    }
    
    func signOut() {
        Task {
            try? await SupabaseService.shared.signOut()
            await MainActor.run {
                self.isAuthenticated = false
            }
        }
    }
    
    func resetPassword() {
        debugMessage += "\nResetPassword called with email: \(email)"
        guard !email.isEmpty else {
            errorMessage = "Please enter your email."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                try await SupabaseService.shared.resetPassword(email: email)
                await MainActor.run {
                    self.isLoading = false
                    self.alertMessage = "Password reset link sent! Check your email."
                    self.showAlert = true
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    self.alertMessage = "Failed to send reset link: \(error.localizedDescription)"
                    self.showAlert = true
                }
            }
        }
    }
    
    func updatePassword() {
        debugMessage += "\nUpdatePassword called"
        
        guard !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Please enter and confirm your new password."
            showAlert = true
            alertMessage = "Please enter and confirm your new password."
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            showAlert = true
            alertMessage = "Passwords do not match."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                try await SupabaseService.shared.updateUser(password: password)
                await MainActor.run {
                    self.isLoading = false
                    self.alertMessage = "Password updated successfully!"
                    self.showAlert = true
                    self.password = ""
                    self.confirmPassword = ""
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    self.alertMessage = "Failed to update password: \(error.localizedDescription)"
                    self.showAlert = true
                }
            }
        }
    }
}
