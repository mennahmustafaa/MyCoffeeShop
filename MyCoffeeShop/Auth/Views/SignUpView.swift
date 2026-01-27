import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            // BACKGROUND IMAGE
            Image("onboarding")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                // TITLE
                Text("Create Account 🌿")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 4)

                // INPUT FIELDS
                VStack(spacing: 16) {
                    // Email
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(12)
                        .frame(width:400)
                    
                    // Password
                    SecureField("Password", text: $viewModel.password)
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(12)
                        .frame(width:400)
                }
                .padding(.horizontal, 30)

                // ERROR MESSAGE
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(8)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                }

                // SIGN UP BUTTON
                Button(action: {
                    viewModel.signUp()
                }) {
                    if viewModel.isLoading {
                        ProgressView().tint(.white)
                    } else {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.Colors.accent)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                            .frame(width:400)
                    }
                }
                .padding(.horizontal, 30)
                .disabled(viewModel.isLoading)

                // DEBUG LOGS
                if !viewModel.debugMessage.isEmpty {
                    ScrollView {
                        Text(viewModel.debugMessage)
                            .font(.caption2)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                    }
                    .frame(height: 100)
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.vertical, 40)
        }
        .onChange(of: viewModel.isAuthenticated) {
            if viewModel.isAuthenticated {
                appState.isAuthenticated = true
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Authentication"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .onChange(of: viewModel.showAlert) { oldValue, newValue in
            if !newValue && viewModel.shouldNavigate {
                viewModel.debugMessage += "\nAlert dismissed. Setting isAuthenticated = true"
                print("SignUpView: Alert dismissed, switching to Home")
                appState.isAuthenticated = true
            }
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AppState())
}
