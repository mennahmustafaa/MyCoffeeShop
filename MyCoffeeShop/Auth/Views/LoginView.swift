import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            // BACKGROUND
            AuthBackgroundView()

            VStack {
                // CARD CONTAINER
                VStack(alignment: .center, spacing: 0) {
                    // TITLE
                    AuthHeaderView()
                    
                    // INPUT FIELDS
                    VStack(spacing: 12) {
                        // Email Field
                        CustomAuthTextField(icon: "envelope", placeholder: "Email", text: $viewModel.email, keyboardType: .emailAddress)
                        
                        // Password Field
                        CustomAuthSecureField(icon: "lock", placeholder: "Password", text: $viewModel.password)
                    }
                    .padding(.bottom, 8)
                    
                    // FORGOT PASSWORD LINK
                    HStack {
                        Spacer()
                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("Forgot password?")
                                .font(Font.custom("Sora", size: 13))
                                .foregroundColor(AppTheme.Colors.background)
                        }
                    }
                    .padding(.bottom, 16)

                    // ERROR MESSAGE
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(8)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(8)
                            .padding(.bottom, 12)
                    }

                    // LOGIN BUTTON
                    AuthButton(title: "Login", isLoading: viewModel.isLoading) {
                        viewModel.signIn()
                    }
                }
                .authCardStyle()
                
                // SIGN UP LINK
                HStack(spacing: 4) {
                    Text("Doesn't have an account?")
                        .font(Font.custom("Sora", size: 14))
                        .kerning(0.14)
                        .foregroundColor(AppTheme.Colors.background)
                    
                    NavigationLink {
                        SignUpView()
                            .environmentObject(appState)
                    } label: {
                        Text("Signup")
                            .font(Font.custom("Sora", size: 14))
                            .kerning(0.14)
                            .foregroundColor(AppTheme.Colors.background)
                            .underline()
                    }
                }
                .frame(width: 327, alignment: .center)
                .padding(.top, 24)
                
                Spacer()
                    .frame(height: 60)
            }
            .padding(.top, 60)
        }
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.isAuthenticated ? "Success" : "Error"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .onChange(of: viewModel.isAuthenticated) { oldValue, newValue in
            if newValue {
                appState.isAuthenticated = true
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
