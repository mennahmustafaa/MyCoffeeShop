//
//  AnimationExtensions.swift
//  MyCoffeeShop
//
//  Created by Antigravity on 30/01/2026.
//

import SwiftUI

// MARK: - Custom Animation Curves
extension Animation {
    /// Smooth spring animation for natural motion
    static var smoothSpring: Animation {
        .spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0)
    }
    
    /// Bouncy spring for playful interactions
    static var bouncySpring: Animation {
        .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)
    }
    
    /// Quick spring for subtle feedback
    static var quickSpring: Animation {
        .spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)
    }
    
    /// Smooth ease out with back effect
    static var easeOutBack: Animation {
        .timingCurve(0.34, 1.56, 0.64, 1, duration: 0.4)
    }
}

// MARK: - View Modifiers

/// Adds a scale animation on button press
struct ButtonPressAnimation: ViewModifier {
    @Binding var isPressed: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.quickSpring, value: isPressed)
    }
}

/// Adds a bounce effect when tapped
struct BounceEffect: ViewModifier {
    @State private var bouncing = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(bouncing ? 1.1 : 1.0)
            .onChange(of: bouncing) { _ in
                if bouncing {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.quickSpring) {
                            bouncing = false
                        }
                    }
                }
            }
    }
    
    func trigger() {
        withAnimation(.bouncySpring) {
            bouncing = true
        }
    }
}

/// Staggered fade-in animation
struct StaggeredFadeIn: ViewModifier {
    let index: Int
    let delay: Double
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : 20)
            .onAppear {
                withAnimation(.easeOut(duration: 0.5).delay(Double(index) * delay)) {
                    isVisible = true
                }
            }
    }
}

/// Slide-in from bottom animation
struct SlideInFromBottom: ViewModifier {
    @State private var isVisible = false
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .offset(y: isVisible ? 0 : 50)
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(.smoothSpring.delay(delay)) {
                    isVisible = true
                }
            }
    }
}

/// Scale and fade-in animation
struct ScaleFadeIn: ViewModifier {
    @State private var isVisible = false
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isVisible ? 1 : 0.5)
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(.smoothSpring.delay(delay)) {
                    isVisible = true
                }
            }
    }
}

/// Shimmer loading effect
struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .clear,
                        .white.opacity(0.3),
                        .clear
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: phase)
                .mask(content)
            )
            .onAppear {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 300
                }
            }
    }
}

// MARK: - View Extensions
extension View {
    /// Applies button press animation
    func buttonPressAnimation(isPressed: Binding<Bool>) -> some View {
        modifier(ButtonPressAnimation(isPressed: isPressed))
    }
    
    /// Applies staggered fade-in animation
    func staggeredFadeIn(index: Int, delay: Double = 0.1) -> some View {
        modifier(StaggeredFadeIn(index: index, delay: delay))
    }
    
    /// Applies slide-in from bottom animation
    func slideInFromBottom(delay: Double = 0) -> some View {
        modifier(SlideInFromBottom(delay: delay))
    }
    
    /// Applies scale and fade-in animation
    func scaleFadeIn(delay: Double = 0) -> some View {
        modifier(ScaleFadeIn(delay: delay))
    }
    
    /// Applies shimmer effect
    func shimmer() -> some View {
        modifier(ShimmerEffect())
    }
    
    /// Adds a subtle bounce when tapped
    func bounceOnTap(action: @escaping () -> Void) -> some View {
        self.onTapGesture {
            withAnimation(.bouncySpring) {
                action()
            }
        }
    }
}
