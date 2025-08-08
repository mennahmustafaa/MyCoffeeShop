import SwiftUI
struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundImage
                blackBottomRectangle
                blurredCardBackground
                loginCard
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                HomeView()
            }
            .alert("Login Failed", isPresented: .constant(viewModel.loginErrorMessage != nil)) {
                Button("OK", role: .cancel) {
                    viewModel.loginErrorMessage = nil
                }
            } message: {
                Text(viewModel.loginErrorMessage ?? "")
            }
        }
    }

    private var backgroundImage: some View {
        Image("onboarding")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }

    private var blackBottomRectangle: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(Color.black)
                .opacity(1)
                .frame(height: 400)
                .ignoresSafeArea(edges: .bottom)
        }
        .offset(y: 20)
    }

    private var blurredCardBackground: some View {
        Image("onboarding")
            .resizable()
            .scaledToFill()
            .blur(radius: 10)
            .mask(
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 320, height: 400)
            )
            .offset(y: -10)
    }

    private var loginCard: some View {
        VStack(spacing: 16) {
            Text("Welcome to Caffi")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("Sign up or log in to discover, order, and enjoy your favorite brews.")
                .font(.subheadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 300)

            emailField
            passwordField

            HStack {
                Spacer()
                Button("Forgot Password?") {
                    // Add action if needed
                }
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.white.opacity(0.8))
                .padding(.trailing, 20)
            }

            Button {
                viewModel.login(email: email, password: password)
            } label: {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 250)
                    .padding()
                    .background(Color(hex: "#C67C4E"))
                    .cornerRadius(10)
            }
            .padding(.top, 10)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 1)
        )
        .frame(width: 330, height: 480)
        .shadow(radius: 70)
    }

    private var emailField: some View {
        HStack {
            Image(systemName: "envelope")
                .foregroundColor(.white.opacity(0.7))
            TextField("", text: $email, prompt: Text("Email").foregroundColor(.white.opacity(0.6)))
                .foregroundColor(.white)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
        }
        .padding()
        .frame(width: 300, height: 50)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 1)
        )
    }

    private var passwordField: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.white.opacity(0.7))
            if isPasswordVisible {
                TextField("", text: $password, prompt: Text("Password").foregroundColor(.white.opacity(0.6)))
                    .foregroundColor(.white)
            } else {
                SecureField("", text: $password, prompt: Text("Password").foregroundColor(.white.opacity(0.6)))
                    .foregroundColor(.white)
            }

            Button {
                isPasswordVisible.toggle()
            } label: {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .padding()
        .frame(width: 300, height: 50)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 1)
        )
    }
}

// MARK: - Preview
#Preview {
    LoginView()
}

// Preview
#Preview {
    LoginView()
}


// .background(Color(hex:#C67C4E)
        //    .cornerRadius(10
