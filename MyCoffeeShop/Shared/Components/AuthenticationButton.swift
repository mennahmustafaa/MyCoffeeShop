import SwiftUI

struct AuthenticationButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 250)
                .padding()
                .background(AppTheme.Colors.primaryBrown)
                .cornerRadius(AppTheme.CornerRadius.standard)
        }
        .padding(.top, 10)
    }
}

