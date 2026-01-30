//
//  ViewModifiers.swift
//  MyCoffeeShop
//
//  Reusable view modifiers for consistent styling
//

import SwiftUI

// MARK: - Padding Modifiers
struct HorizontalPaddingModifier: ViewModifier {
    let padding: CGFloat
    
    init(_ padding: CGFloat = AppTheme.Spacing.horizontalPadding) {
        self.padding = padding
    }
    
    func body(content: Content) -> some View {
        content.padding(.horizontal, padding)
    }
}

extension View {
    func horizontalPadding(_ padding: CGFloat = AppTheme.Spacing.horizontalPadding) -> some View {
        modifier(HorizontalPaddingModifier(padding))
    }
}

// MARK: - Divider Views
struct StandardDivider: View {
    let height: CGFloat
    let color: Color
    
    init(height: CGFloat = 1, color: Color = AppTheme.Colors.divider) {
        self.height = height
        self.color = color
    }
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: height)
    }
}

struct ThickDivider: View {
    var body: some View {
        Rectangle()
            .fill(AppTheme.Colors.dividerThick)
            .frame(height: 4)
    }
}

// MARK: - Card Style
struct CardStyleModifier: ViewModifier {
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    
    init(cornerRadius: CGFloat = AppTheme.CornerRadius.large,
         shadowRadius: CGFloat = AppTheme.Shadow.card.radius) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
    }
    
    func body(content: Content) -> some View {
        content
            .background(AppTheme.Colors.background)
            .cornerRadius(cornerRadius)
            .shadow(
                color: AppTheme.Shadow.card.color,
                radius: shadowRadius,
                x: AppTheme.Shadow.card.x,
                y: AppTheme.Shadow.card.y
            )
    }
}

extension View {
    func cardStyle(cornerRadius: CGFloat = AppTheme.CornerRadius.large) -> some View {
        modifier(CardStyleModifier(cornerRadius: cornerRadius))
    }
}

// MARK: - Button Styles
struct PrimaryButtonStyle: ButtonStyle {
    let isLoading: Bool
    
    init(isLoading: Bool = false) {
        self.isLoading = isLoading
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTheme.Typography.headline())
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(isLoading ? AppTheme.Colors.primaryBrown.opacity(0.7) : AppTheme.Colors.primaryBrown)
            .cornerRadius(AppTheme.CornerRadius.extraLarge)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(AppTheme.Animation.quick, value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTheme.Typography.caption())
            .foregroundColor(AppTheme.Colors.secondaryText)
            .padding(.horizontal, AppTheme.Spacing.mediumSpacing)
            .padding(.vertical, 6)
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                    .stroke(AppTheme.Colors.secondaryText.opacity(0.3), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(AppTheme.Animation.quick, value: configuration.isPressed)
    }
}

extension View {
    func primaryButtonStyle(isLoading: Bool = false) -> some View {
        buttonStyle(PrimaryButtonStyle(isLoading: isLoading))
    }
    
    func secondaryButtonStyle() -> some View {
        buttonStyle(SecondaryButtonStyle())
    }
}
