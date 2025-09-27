//
//  Untitled.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI

struct QuantityControlView: View {
    let quantity: Int
    let onIncrease: () -> Void
    let onDecrease: () -> Void

    var body: some View {
        HStack(spacing: 15) {
            Button(action: onDecrease) {
                Image(systemName: "minus")
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .bold))
            }

            Text("\(quantity)")
                .font(.system(size: 16, weight: .semibold))
                .frame(minWidth: 20)

            Button(action: onIncrease) {
                Image(systemName: "plus")
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .bold))
            }
        }
    }
}

#Preview {
    QuantityControlView(quantity: 2, onIncrease: {}, onDecrease: {})
      //  .previewLayout(.sizeThatFits)
        .padding()
}
