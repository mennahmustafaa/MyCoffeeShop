import SwiftUI

struct AuthBackgroundView: View {
    var body: some View {
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
}

struct AuthHeaderView: View {
    var title: String = "Welcome to SipSpot"
    var subtitle: String = "Sign up or log in to discover,\n order, and enjoy your favorite brews."
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(
                    Font.custom("Sora", size: 24)
                        .weight(.semibold)
                )
                .kerning(0.12)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(width: 327, alignment: .top)
                .padding(.bottom, 8)
            
            Text(subtitle)
                .font(Font.custom("Sora", size: 14))
                .kerning(0.14)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                .frame(maxWidth: .infinity, alignment: .top)
                .lineLimit(nil)
                .padding(.bottom, 24)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct CustomAuthTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(isFocused ? AppTheme.Colors.primaryBrown : AppTheme.Colors.background)
                .frame(width: 20)
                .animation(.easeInOut(duration: 0.2), value: isFocused)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.7))
                }
                TextField("", text: $text)
                    .keyboardType(keyboardType)
                    .autocapitalization(keyboardType == .emailAddress ? .none : .words)
                    .foregroundColor(.white)
                    .focused($isFocused)
            }
            .frame(height: 24)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(isFocused ? 0.1 : 0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isFocused ? AppTheme.Colors.primaryBrown : Color.white, lineWidth: 2)
                )
        )
        .cornerRadius(12)
        .scaleEffect(isFocused ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

struct CustomAuthSecureField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    @State private var isSecured: Bool = true
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(isFocused ? AppTheme.Colors.primaryBrown : AppTheme.Colors.background)
                .frame(width: 20)
                .animation(.easeInOut(duration: 0.2), value: isFocused)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                if isSecured {
                    SecureField("", text: $text)
                        .foregroundColor(.white)
                        .focused($isFocused)
                } else {
                    TextField("", text: $text)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                        .focused($isFocused)
                }
            }
            .frame(height: 24)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.15)) {
                    isSecured.toggle()
                }
            }) {
                Image(systemName: isSecured ? "eye" : "eye.slash")
                    .foregroundColor(isFocused ? AppTheme.Colors.primaryBrown : AppTheme.Colors.background)
                    .frame(width: 16, height: 16)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(isFocused ? 0.1 : 0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isFocused ? AppTheme.Colors.primaryBrown : Color.white, lineWidth: 2)
                )
        )
        .cornerRadius(12)
        .scaleEffect(isFocused ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

struct AuthButton: View {
    let title: String
    let isLoading: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
                action()
            }
        }) {
            if isLoading {
                ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                Text(title)
                    .font(Font.custom("Sora", size: 16).weight(.semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .background(AppTheme.Colors.primaryBrown)
        .cornerRadius(12)
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .shadow(color: AppTheme.Colors.primaryBrown.opacity(isPressed ? 0.3 : 0.5), radius: isPressed ? 4 : 8, y: isPressed ? 2 : 4)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .disabled(isLoading)
    }
}

struct AuthCardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
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
    }
}

extension View {
    func authCardStyle() -> some View {
        modifier(AuthCardBackground())
    }
}
