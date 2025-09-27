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
                .background(Color.orange)
                .cornerRadius(16)
            }
            .disabled(isLoading)
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 20)
            .background(Color.white)
        }
    }
}

#Preview("Order Button - Normal") {
    OrderButtonView(isLoading: false, onOrderTapped: {})
     //   .previewLayout(.sizeThatFits)
        .padding()
}

