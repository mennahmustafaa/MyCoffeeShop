import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            // BACKGROUND
            AuthBackgroundView()
            
            VStack {
                // CARD CONTAINER
                VStack(alignment: .center, spacing: 0) {
                    // HEADER
                    AuthHeaderView()
                    
                    // INPUTS
                    VStack(spacing: 12) {
                        // Name Field
                        CustomAuthTextField(icon: "person", placeholder: "Name", text: $viewModel.name)
                        
                        // Email Field
                        CustomAuthTextField(icon: "envelope", placeholder: "Email", text: $viewModel.email, keyboardType: .emailAddress)
                        
                        // Phone Number Field
                        CustomAuthTextField(icon: "phone", placeholder: "Phone Number", text: $viewModel.phoneNumber, keyboardType: .phonePad)
                        
                        // Password Field
                        CustomAuthSecureField(icon: "lock", placeholder: "Password", text: $viewModel.password)
                        
                        // Confirm Password Field
                        CustomAuthSecureField(icon: "lock", placeholder: "Confirm Password", text: $viewModel.confirmPassword)
                    }
                    .padding(.bottom, 24)

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

                    // SIGN UP BUTTON
                    AuthButton(title: "Sign up", isLoading: viewModel.isLoading) {
                        viewModel.signUp()
                    }
                    
                    // TERMS
                    Text("by signing up, you agree to our\nTerms & Policy")
                        .font(Font.custom("Sora", size: 12))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 16)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .authCardStyle()
                
                // FOOTER
                HStack(spacing: 4) {
                    Text("Have an account?")
                        .font(Font.custom("Sora", size: 14))
                        .kerning(0.14)
                        .foregroundColor(AppTheme.Colors.background)
                    
                    Button {
                        print("Login button tapped")
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Login")
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
    SignUpView()
        .environmentObject(AppState())
}
