import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = AuthViewModel()
    @Environment(\.dismiss) var dismiss
    
    // Focus state for accessibility and UX
    @FocusState private var isEmailFocused: Bool

    var body: some View {
        ZStack {
            // BACKGROUND
            // Using a dark gradient overlay on the image for better text contrast
            ZStack {
                Image("onboarding") // Ensure this asset exists
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // Overlay for readability
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                // Ambient gradient for premium feel
                LinearGradient(
                    colors: [Color.black.opacity(0.6), Color.clear, Color.black.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }

            VStack(spacing: 0) {
                // NAVIGATION BAR
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .bold))
                            Text("Back")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(.ultraThinMaterial) // Glass effect
                        .clipShape(Capsule())
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 50) // Adjust for safe area
                
                Spacer()
                
                // GLASS CARD CONTENT
                VStack(spacing: 24) {
                    // Icon & Title
                    VStack(spacing: 12) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.white, .white.opacity(0.7)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .shadow(color: .white.opacity(0.5), radius: 10)
                        
                        Text("Forgot Password?")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Enter your email correctly and we'll send you instructions to reset your password.")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    // Input Field
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.white.opacity(0.7))
                            
                            TextField("Email Address", text: $viewModel.email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .foregroundColor(.white)
                                .focused($isEmailFocused)
                                .accentColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isEmailFocused ? Color.white.opacity(0.8) : Color.white.opacity(0.3), lineWidth: 1)
                        )
                        
                        // Error Message
                        if let error = viewModel.errorMessage {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                Text(error)
                            }
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                            .transition(.opacity)
                        }
                        
                        // Action Button
                        Button(action: {
                            isEmailFocused = false
                            viewModel.resetPassword()
                        }) {
                            ZStack {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Text("Send Reset Link")
                                        .fontWeight(.bold)
                                        .font(.system(size: 18))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [AppTheme.Colors.primaryBrown, AppTheme.Colors.primaryBrown.opacity(0.8)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .shadow(color: AppTheme.Colors.primaryBrown.opacity(0.4), radius: 8, x: 0, y: 4)
                        }
                        .disabled(viewModel.isLoading)
                        .opacity(viewModel.isLoading ? 0.7 : 1)
                    }
                }
                .padding(30)
                .background(.ultraThinMaterial) // The "Glass"
                .cornerRadius(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.errorMessage == nil ? "Success" : "Error"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK")) {
                    if viewModel.errorMessage == nil {
                        dismiss()
                    }
                }
            )
        }
        .onAppear {
            isEmailFocused = true
        }
    }
}

#Preview {
    NavigationStack {
        ZStack {
            // Mock Background for Preview context
            Color.black.ignoresSafeArea()
            ForgotPasswordView()
        }
    }
}
