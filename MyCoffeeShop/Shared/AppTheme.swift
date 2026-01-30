//
//  AppTheme.swift
//  MyCoffeeShop
//
//  Centralized theme system for consistent styling across the app
//

import SwiftUI

enum AppTheme {
    
    // MARK: - Colors
    enum Colors {
        // Primary Colors
        static let primaryBrown = Color(hex: "#C67C4E")
        static let darkGray = Color(hex: "#2A2A2A")
        static let lightGray = Color(hex: "#F4F4F4")
        
        // Semantic Colors
        static let background = Color.white
        static let secondaryBackground = Color.gray.opacity(0.1)
        static let divider = Color.gray.opacity(0.2)
        static let dividerThick = Color.gray.opacity(0.2)
        
        // Text Colors
        static let primaryText = Color.black
        static let secondaryText = Color.gray
        static let tertiaryText = Color.white.opacity(0.7)
        
        // Accent Colors
        static let accent = Color(hex: "#C67C4E")
        static let error = Color.red
        static let success = Color.green
        static let warning = Color.yellow
    }
    
    // MARK: - Spacing
    enum Spacing {
        static let horizontalPadding: CGFloat = 20
        static let verticalSpacing: CGFloat = 20
        static let cardPadding: CGFloat = 16
        static let smallSpacing: CGFloat = 8
        static let mediumSpacing: CGFloat = 12
        static let largeSpacing: CGFloat = 24
    }
    
    // MARK: - Corner Radius
    enum CornerRadius {
        static let small: CGFloat = 6
        static let medium: CGFloat = 8
        static let standard: CGFloat = 10
        static let large: CGFloat = 12
        static let extraLarge: CGFloat = 16
        static let rounded: CGFloat = 20
    }
    
    // MARK: - Typography
    enum Typography {
        // Title Styles
        static func title(_ size: CGFloat = 24, weight: Font.Weight = .bold) -> Font {
            .system(size: size, weight: weight)
        }
        
        static func title2(_ size: CGFloat = 20, weight: Font.Weight = .semibold) -> Font {
            .system(size: size, weight: weight)
        }
        
        // Headline Styles
        static func headline(_ size: CGFloat = 16, weight: Font.Weight = .semibold) -> Font {
            .system(size: size, weight: weight)
        }
        
        // Body Styles
        static func body(_ size: CGFloat = 14, weight: Font.Weight = .regular) -> Font {
            .system(size: size, weight: weight)
        }
        
        static func bodyMedium(_ size: CGFloat = 14, weight: Font.Weight = .medium) -> Font {
            .system(size: size, weight: weight)
        }
        
        // Caption Styles
        static func caption(_ size: CGFloat = 12, weight: Font.Weight = .regular) -> Font {
            .system(size: size, weight: weight)
        }
        
        static func captionMedium(_ size: CGFloat = 12, weight: Font.Weight = .medium) -> Font {
            .system(size: size, weight: weight)
        }
    }
    
    // MARK: - Shadows
    enum Shadow {
        static let card = (color: Color.black.opacity(0.08), radius: CGFloat(8), x: CGFloat(0), y: CGFloat(4))
        static let button = (color: Color.black.opacity(0.1), radius: CGFloat(4), x: CGFloat(0), y: CGFloat(2))
    }
    
    // MARK: - Animation
    enum Animation {
        static let standard = SwiftUI.Animation.easeInOut(duration: 0.3)
        static let quick = SwiftUI.Animation.easeInOut(duration: 0.2)
        static let slow = SwiftUI.Animation.easeInOut(duration: 0.5)
    }
}
