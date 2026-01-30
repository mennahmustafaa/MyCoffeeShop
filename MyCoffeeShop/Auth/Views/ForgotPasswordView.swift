import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            // BACKGROUND
            AuthBackgroundView()
            
            VStack {
                // CARD CONTAINER
                VStack(alignment: .center, spacing: 0) {
                    // HEADER
                    AuthHeaderView(
                        title: "Forgot Password?",
                        subtitle: "Enter your email correctly and we'll send you instructions to reset your password."
                    )
                    
                    // INPUTS
                    VStack(spacing: 12) {
                        CustomAuthTextField(icon: "envelope", placeholder: "Email", text: $viewModel.email, keyboardType: .emailAddress)
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

                    // ACTION BUTTON
                    AuthButton(title: "Send Reset Link", isLoading: viewModel.isLoading) {
                        viewModel.resetPassword()
                    }
                }
                .authCardStyle()
                
                // FOOTER
                HStack(spacing: 4) {
                    Text("Remember password?")
                        .font(Font.custom("Sora", size: 14))
                        .kerning(0.14)
                        .foregroundColor(AppTheme.Colors.background)
                    
                    Button {
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
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.errorMessage == nil ? "Success" : "Error"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK")) {
                    if viewModel.errorMessage == nil {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
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
