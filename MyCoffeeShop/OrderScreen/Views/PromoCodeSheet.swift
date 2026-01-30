//
//  PromoCodeSheet.swift
//  MyCoffeeShop
//
//  Created by Mennah on 04/12/2025.
//

import SwiftUI

struct PromoCodeSheet: View {
    @Binding var promoCode: String
    var onApply: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            // Handle bar
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 4)
                .padding(.top, 12)
            
            Text("Discount")
                .font(.title3)
                .bold()
            
            TextField("Promo Code ...", text: $promoCode)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal)
            
            Button(action: {
                onApply()
                dismiss()
            }) {
                Text("Apply")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.Colors.accent)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .background(Color.white)
        .cornerRadius(24)
    }
}

#Preview {
    PromoCodeSheet(promoCode: .constant(""), onApply: {})
}
