//
//  DiscountView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI

struct DiscountView: View {
    let discountText: String
    var onTap: (() -> Void)? = nil

    var body: some View {
        Button(action: { onTap?() }) {
            HStack {
            Image(systemName: "percent")
                .foregroundColor(AppTheme.Colors.accent)
                .font(.system(size: 16))

            Text(discountText)
                .font(AppTheme.Typography.body())
                .foregroundColor(AppTheme.Colors.primaryText)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(AppTheme.Colors.secondaryText)
                .font(AppTheme.Typography.caption())
        }
        .padding(.horizontal, AppTheme.Spacing.horizontalPadding)
        .padding(.vertical, AppTheme.Spacing.mediumSpacing)
        .background(AppTheme.Colors.secondaryBackground.opacity(0.5))
        .cornerRadius(AppTheme.CornerRadius.medium)
        .horizontalPadding()
    }
    }
}

#Preview {
    DiscountView(discountText: "1 Discount is Applies")
       // .previewLayout(.sizeThatFits)
        .padding()
}
