import SwiftUI

struct AuthenticationBackgroundView: View {
    let cardHeight: CGFloat
    
    var body: some View {
        ZStack {
            backgroundImage
            blackBottomRectangle
            blurredCardBackground
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
                .frame(height: cardHeight + 100)
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
                    .frame(width: 320, height: cardHeight)
            )
            .offset(y: -10)
    }
}

