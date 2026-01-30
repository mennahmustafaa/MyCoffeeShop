import SwiftUI

struct AuthenticationTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white.opacity(0.7))
            
            if isSecure {
                if isPasswordVisible {
                    TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.6)))
                        .foregroundColor(.white)
                } else {
                    SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.6)))
                        .foregroundColor(.white)
                }
                
                Button {
                    isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.white.opacity(0.7))
                }
            } else {
                TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.6)))
                    .foregroundColor(.white)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
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

