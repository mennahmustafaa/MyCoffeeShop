import SwiftUI

struct SignupView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isPasswordVisible = false
    @StateObject private var viewModel = SignupViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundImage
                blackBottomRectangle
                blurredCardBackground
                signupCard
            }
            .navigationDestination(isPresented: $viewModel.isSignedUp) {
                HomeView()
            }
            .alert("Signup Failed", isPresented: .constant(viewModel.signupErrorMessage != nil)) {
                Button("OK", role: .cancel) {
                    viewModel.signupErrorMessage = nil
                }
            } message: {
                Text(viewModel.signupErrorMessage ?? "")
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
                .frame(height: 500)
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
                    .frame(width: 320, height: 580)
            )
            .offset(y: -10)
    }

    private var signupCard: some View {
        VStack(spacing: 16) {
            Text("Create an Account")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Join Caffi to order and enjoy your favorite brews.")
                .font(.subheadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 300)
            
            inputField(icon: "person", placeholder: "Full Name", text: $name)
            inputField(icon: "envelope", placeholder: "Email", text: $email)
            passwordField
            confirmPasswordField
            
            Button {
                viewModel.signup(name: name, email: email, password: password, confirmPassword: confirmPassword)
            } label: {
                Text("Sign Up")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 250)
                    .padding()
                    .background(Color(hex: "#C67C4E"))
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            
            // ✅ Terms & Conditions with bold styling
            (
                Text("By signing up, you agree to our \n")
                + Text("Terms & Conditions").bold()
            )
            .font(.footnote)
            .foregroundColor(.white) // ✅ vibrant white
            .multilineTextAlignment(.center)
            .frame(width: 280)
            .padding(.top, 4)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 1)
        )
        .frame(width: 330, height: 600)
        .shadow(radius: 70)
    }

    private func inputField(icon: String, placeholder: String, text: Binding<String>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white.opacity(0.7))
            TextField("", text: text, prompt: Text(placeholder).foregroundColor(.white.opacity(1)))
                .foregroundColor(.white)
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

    private var confirmPasswordField: some View {
        HStack {
            Image(systemName: "lock.fill")
                .foregroundColor(.white.opacity(0.7))
            SecureField("", text: $confirmPassword, prompt: Text("Confirm Password").foregroundColor(.white.opacity(0.6)))
                .foregroundColor(.white)
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

// ✅ Preview
#Preview {
    SignupView()
}

