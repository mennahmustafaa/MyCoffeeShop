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
                    .blur(radius: 3)
                    .ignoresSafeArea()
                
                // GRADIENT OVERLAY
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

                VStack {
                    // CARD CONTAINER
                    VStack(alignment: .center, spacing: 0) {
                            // TITLE
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
                            
                            // INPUT FIELDS
                            VStack(spacing: 12) {
                                
                                // Email Field
                                HStack(spacing: 12) {
                                    Image(systemName: "envelope")
                                        .foregroundColor(AppTheme.Colors.background)
                                        .frame(width: 20)
                                    
                                    ZStack(alignment: .leading) {
                                        if viewModel.email.isEmpty {
                                            Text("Email")
                                                .foregroundColor(.white.opacity(0.7))
                                        }
                                        TextField("", text: $viewModel.email)
                                            .keyboardType(.emailAddress)
                                            .autocapitalization(.none)
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
                                
                                // Password Field
                                HStack(spacing: 12) {
                                    Image(systemName: "lock")
                                        .foregroundColor(AppTheme.Colors.background)
                                        .frame(width: 20)
                                    
                                    ZStack(alignment: .leading) {
                                        if viewModel.password.isEmpty {
                                            Text("Password")
                                                .foregroundColor(.white.opacity(0.7))
                                        }
                                        SecureField("", text: $viewModel.password)
                                            .foregroundColor(.white)
                                    }
                                    
                                    Image(systemName: "eye.slash")
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
                            Button(action: {
                                viewModel.signIn()
                            }) {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .tint(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                } else {
                                    Text("Login")
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
