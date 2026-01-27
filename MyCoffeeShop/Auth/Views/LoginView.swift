import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {		
        NavigationStack {
            ZStack {
                // BACKGROUND IMAGE
                Image("onboarding")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    // TITLE
                    Text("Welcome Back ☕")
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
                            .background(Color.white.opacity(0.8))	
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
                    
                    // FORGOT PASSWORD LINK
                    HStack {
                        Spacer()
                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("Forgot Password?")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .underline()
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, -10)

                    // ERROR MESSAGE
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(8)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                    }

                    // LOGIN BUTTON
                    Button(action: {
                        viewModel.signIn()
                    }) {
                        if viewModel.isLoading {
                            ProgressView().tint(.white)
                        } else {
                            Text("Sign In")
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

                    // SIGN UP LINK
                    NavigationLink {
                        SignUpView()
                            .environmentObject(appState)
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(.white)
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .underline()
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 10)

                    Spacer()
                }
                .padding(.vertical, 40)
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
            .onChange(of: viewModel.showAlert) { oldValue, newValue in
                if !newValue && viewModel.shouldNavigate {
                    viewModel.debugMessage += "\nAlert dismissed. Setting isAuthenticated = true"
                    print("LoginView: Alert dismissed, switching to Home")
                    appState.isAuthenticated = true
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
