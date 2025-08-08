//
//  DiscountView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI

struct DiscountView: View {
    let discountText: String

    var body: some View {
        HStack {
            Image(systemName: "percent")
                .foregroundColor(.orange)
                .font(.system(size: 16))

            Text(discountText)
                .font(.system(size: 14))
                .foregroundColor(.black)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 12))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        .padding(.horizontal, 20)
    }
}

#Preview {
    DiscountView(discountText: "1 Discount is Applies")
       // .previewLayout(.sizeThatFits)
        .padding()
}
