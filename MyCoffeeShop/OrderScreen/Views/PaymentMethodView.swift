//
//  PaymentMethodView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI

struct PaymentMethodView: View {
    let selectedMethod: PaymentMethod
    let walletBalance: String
    let onMethodTapped: () -> Void

    var body: some View {
        HStack {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.orange.opacity(0.2))
                    .frame(width: 24, height: 24)
                    .overlay(
                        Image(systemName: selectedMethod.iconName)
                            .foregroundColor(.orange)
                            .font(.system(size: 12))
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(selectedMethod.title)
                        .font(.system(size: 14, weight: .medium))
                    Text(walletBalance)
                        .font(.system(size: 12))
                        .foregroundColor(.orange)
                }
            }

            Spacer()

            Button(action: onMethodTapped) {
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    PaymentMethodView(
        selectedMethod: .creditCard,
        walletBalance: "$12.34",
        onMethodTapped: {}
    )
    //.previewLayout(.sizeThatFits)
    .padding()
}
