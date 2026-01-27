import SwiftUI

struct AuthenticationCard<Content: View>: View {
    let title: String
    let subtitle: String
    let cardHeight: CGFloat
    let content: Content
    
    init(title: String, subtitle: String, cardHeight: CGFloat = 480, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.cardHeight = cardHeight
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 300)
            
            content
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 1)
        )
        .frame(width: 330, height: cardHeight)
        .shadow(radius: 70)
    }
}

