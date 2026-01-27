import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            ZStack {
                // BACKGROUND
                backgroundView
                
                VStack {
                    // CARD CONTAINER
                    VStack(alignment: .center, spacing: 0) {
                        headerView
                        
                        inputFieldsView
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

                        signUpButton
                        
                        termsText
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 40)
                    .frame(width: 327, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black.opacity(0.5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 0.93, green: 0.84, blue: 0.78).opacity(0.4), lineWidth: 1)
                            )
                    )
                    
                    footerView
                    
                    Spacer()
                        .frame(height: 60)
                }
                .padding(.top, 60)
            }
            .onChange(of: viewModel.isAuthenticated) { oldValue, newValue in
                 if newValue {
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
        }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var backgroundView: some View {
        ZStack {
            Image("onboarding")
                .resizable()
                .scaledToFill()
                .blur(radius: 3)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 360)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.02, green: 0.02, blue: 0.02).opacity(0), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.02, green: 0.02, blue: 0.02), location: 0.24),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    private var headerView: some View {
        Text("Welcome to SipSpot")
            .font(
                Font.custom("Sora", size: 24)
                    .weight(.semibold)
            )
            .kerning(0.12)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .frame(width: 327, alignment: .top)
            .padding(.bottom, 8)
        
        Text("Sign up or log in to discover, order, and enjoy your favorite brews.")
            .font(Font.custom("Sora", size: 14))
            .kerning(0.14)
            .multilineTextAlignment(.center)
            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
            .frame(maxWidth: .infinity, alignment: .top)
            .padding(.bottom, 24)
    }
    
    @ViewBuilder
    private var inputFieldsView: some View {
        VStack(spacing: 12) {
            // Name Field
            customTextField(icon: "person", placeholder: "Name", text: $viewModel.name)
            
            // Email Field
            customTextField(icon: "envelope", placeholder: "Email", text: $viewModel.email, keyboardType: .emailAddress)
            
            // Phone Number Field
            customTextField(icon: "phone", placeholder: "Phone Number", text: $viewModel.phoneNumber, keyboardType: .phonePad)
            
            // Password Field
            customSecureField(icon: "lock", placeholder: "Password", text: $viewModel.password)
            
            // Confirm Password Field
            customSecureField(icon: "lock", placeholder: "Confirm Password", text: $viewModel.confirmPassword)
        }
    }
    
    @ViewBuilder
    private func customTextField(icon: String, placeholder: String, text: Binding<String>, keyboardType: UIKeyboardType = .default) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(AppTheme.Colors.background)
                .frame(width: 20)
            
            ZStack(alignment: .leading) {
                if text.wrappedValue.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.7))
                }
                TextField("", text: text)
                    .keyboardType(keyboardType)
                    .autocapitalization(keyboardType == .emailAddress ? .none : .words)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white, lineWidth: 2)
                )
        )
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private func customSecureField(icon: String, placeholder: String, text: Binding<String>) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(AppTheme.Colors.background)
                .frame(width: 20)
            
            ZStack(alignment: .leading) {
                if text.wrappedValue.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.7))
                }
                SecureField("", text: text)
                    .foregroundColor(.white)
            }
            
            Image(systemName: "eye")
                .foregroundColor(AppTheme.Colors.background)
                .frame(width: 16, height: 16)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white, lineWidth: 2)
                )
        )
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private var signUpButton: some View {
        Button(action: {
            viewModel.signUp()
        }) {
            if viewModel.isLoading {
                ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                Text("Sign up")
                    .font(Font.custom("Sora", size: 16).weight(.semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .background(AppTheme.Colors.primaryBrown)
        .cornerRadius(12)
        .disabled(viewModel.isLoading)
    }
    
    @ViewBuilder
    private var termsText: some View {
        Text("by signing up, you agree to our\nTerms & Policy")
            .font(Font.custom("Sora", size: 12))
            .multilineTextAlignment(.center)
            .foregroundColor(.white.opacity(0.8))
            .padding(.top, 16)
    }
    
    @ViewBuilder
    private var footerView: some View {
        HStack(spacing: 4) {
            Text("Have an account?")
                .font(Font.custom("Sora", size: 14))
                .kerning(0.14)
                .foregroundColor(AppTheme.Colors.background)
            
            Button {
                // Dismiss action would be ideal here if presented
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
    }
}

#Preview {
    SignUpView()
        .environmentObject(AppState())
}
