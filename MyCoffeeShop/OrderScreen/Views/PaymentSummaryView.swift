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

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Payment Summary")
                .font(.system(size: 16, weight: .semibold))

            HStack {
                Text("Price")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                Spacer()
                Text(String(format: "$ %.2f", itemPrice))
                    .font(.system(size: 14, weight: .semibold))
            }

            if originalDeliveryFee > 0 {
                HStack {
                    Text("Delivery Fee")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Spacer()
                    HStack(spacing: 8) {
                        Text(String(format: "$%.1f", originalDeliveryFee))
                            .font(.system(size: 14))
                            .strikethrough()
                            .foregroundColor(.gray)
                        Text(String(format: "$%.1f", deliveryFee))
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    PaymentSummaryView(itemPrice: 9.06, originalDeliveryFee: 2.0, deliveryFee: 1.0)
     //   .previewLayout(.sizeThatFits)
        .padding()
}
