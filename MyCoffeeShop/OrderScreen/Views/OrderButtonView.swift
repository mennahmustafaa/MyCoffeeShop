//
//  OrderButtonView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI

struct OrderButtonView: View {
    let isLoading: Bool
    let onOrderTapped: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1)

            Button(action: onOrderTapped) {
                HStack {
                    if isLoading {
                        ProgressView()
                            .scaleEffect(0.8)
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }

                    Text(isLoading ? "Processing..." : "Order")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(AppTheme.Colors.accent)
                .cornerRadius(AppTheme.CornerRadius.extraLarge)
            }
            .disabled(isLoading)
            .horizontalPadding()
            .padding(.top, AppTheme.Spacing.cardPadding)
            .padding(.bottom, AppTheme.Spacing.verticalSpacing)
            .background(AppTheme.Colors.background)
        }
    }
}

#Preview("Order Button - Normal") {
    OrderButtonView(isLoading: false, onOrderTapped: {})
     //   .previewLayout(.sizeThatFits)
        .padding()
}

