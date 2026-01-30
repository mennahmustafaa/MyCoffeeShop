//
//  PaymentSummaryView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI

struct PaymentSummaryView: View {
    let itemPrice: Double
    let originalDeliveryFee: Double
    let deliveryFee: Double
    let discountAmount: Double
    let totalAmount: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Payment Summary")
                .font(AppTheme.Typography.headline())

            HStack {
                Text("Price")
                    .font(AppTheme.Typography.body())
                    .foregroundColor(AppTheme.Colors.primaryText)
                Spacer()
                Text(String(format: "$ %.2f", itemPrice))
                    .font(AppTheme.Typography.bodyMedium())
            }

            if originalDeliveryFee > 0 {
                HStack {
                    Text("Delivery Fee")
                        .font(AppTheme.Typography.body())
                        .foregroundColor(AppTheme.Colors.primaryText)
                    Spacer()
                    HStack(spacing: 8) {
                        Text(String(format: "$%.1f", originalDeliveryFee))
                            .font(AppTheme.Typography.body())
                            .strikethrough()
                            .foregroundColor(AppTheme.Colors.secondaryText)
                        Text(String(format: "$%.1f", deliveryFee))
                            .font(AppTheme.Typography.bodyMedium())
                    }
                }
            }
            
            if discountAmount > 0 {
                HStack {
                    Text("Discount")
                        .font(AppTheme.Typography.body())
                        .foregroundColor(AppTheme.Colors.primaryText)
                    Spacer()
                    Text(String(format: "-$%.2f", discountAmount))
                        .font(AppTheme.Typography.bodyMedium())
                        .foregroundColor(AppTheme.Colors.accent)
                }
            }
            
            StandardDivider()
            
            HStack {
                Text("Total Payment")
                    .font(AppTheme.Typography.body())
                    .foregroundColor(AppTheme.Colors.primaryText)
                Spacer()
                Text(String(format: "$ %.2f", totalAmount))
                    .font(AppTheme.Typography.bodyMedium())
            }
        }
        .horizontalPadding()
    }
}

#Preview {
    PaymentSummaryView(itemPrice: 9.06, originalDeliveryFee: 2.0, deliveryFee: 1.0, discountAmount: 0.45, totalAmount: 9.61)
     //   .previewLayout(.sizeThatFits)
        .padding()
}
