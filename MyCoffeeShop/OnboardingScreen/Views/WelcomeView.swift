// WelcomeView.swift
import SwiftUI

struct Welcome: View {
    @ObservedObject var viewModel: OnboardingViewModel
    var onComplete: () -> Void
    
    @State private var showContent = false
    @State private var buttonPressed = false
    @State private var imageScale: CGFloat = 1.1

    var body: some View {
        VStack(spacing: 0) {
            TabView {
                ForEach(pages) { page in
                    VStack(spacing: 0) {
                        Image(page.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.712)
                            .scaleEffect(imageScale)
                            .clipped()
                            .ignoresSafeArea(.all, edges: .top)

                        VStack(spacing: 20) {
                            VStack {
                                Text(page.label)
                                    .font(.system(size: 28, weight: .semibold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineSpacing(7)
                                    .scaleEffect(x: 1.4, y: 1.15)
                            }
                            .offset(y: showContent ? -110 : -60)
                            .opacity(showContent ? 1 : 0)

                            VStack {
                                Text(page.text)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .offset(y: showContent ? -100 : -50)
                            .opacity(showContent ? 1 : 0)

                            VStack {
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        buttonPressed = true
                                    }
                                    
                                    // Haptic feedback
                                    let impact = UIImpactFeedbackGenerator(style: .medium)
                                    impact.impactOccurred()
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                            buttonPressed = false
                                        }
                                        onComplete()
                                    }
                                }) {
                                    Text("Get Started")
                                        .font(Font.custom("Sora", size: 16).weight(.semibold))
                                        .foregroundColor(.white)
                                        .frame(width: 327, height: 56)
                                        .background(AppTheme.Colors.primaryBrown)
                                        .cornerRadius(16)
                                        .scaleEffect(buttonPressed ? 0.92 : 1.0)
                                        .shadow(color: AppTheme.Colors.primaryBrown.opacity(buttonPressed ? 0.3 : 0.5), 
                                               radius: buttonPressed ? 8 : 12, 
                                               y: buttonPressed ? 4 : 6)
                                }
                                .padding(.top, 10)
                                .offset(y: showContent ? -100 : -40)
                                .opacity(showContent ? 1 : 0)
                            }
                        }
                        .padding(.vertical, 5)
                        .frame(width: 327, height: 194)
                        .background(Color.black)

                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .ignoresSafeArea(.all, edges: .top)
        }
        .onAppear {
            // Subtle zoom animation for image
            withAnimation(.easeOut(duration: 8).repeatForever(autoreverses: true)) {
                imageScale = 1.0
            }
            
            // Staggered content appearance
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                showContent = true
            }
        }
    }
}
