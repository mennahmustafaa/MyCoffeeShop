import SwiftUI

struct ChangePasswordView: View {
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
                        title: "Change Password",
                        subtitle: "Enter your new password below."
                    )
                    
                    // INPUTS
                    VStack(spacing: 12) {
                        CustomAuthSecureField(icon: "lock", placeholder: "New Password", text: $viewModel.password)
                        
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

                    // ACTION BUTTON
                    AuthButton(title: "Update Password", isLoading: viewModel.isLoading) {
                        viewModel.updatePassword()
                    }
                }
                .authCardStyle()
                
                // BACK BUTTON
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Back")
                        .font(Font.custom("Sora", size: 14))
                        .kerning(0.14)
                        .foregroundColor(AppTheme.Colors.background)
                        .underline()
                }
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
    ChangePasswordView()
}
