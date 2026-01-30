//
//  CoffeeItemView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI

struct CoffeeItemView: View {
    let item: CoffeeItem
    let quantity: Int
    let onIncrease: () -> Void
    let onDecrease: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.brown.opacity(0.7))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: item.imageName)
                        .foregroundColor(.white)
                        .font(.title2)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.system(size: 16, weight: .semibold))

                Text(item.subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)

                Spacer()
            }

            Spacer()

            QuantityControlView(
                quantity: quantity,
                onIncrease: onIncrease,
                onDecrease: onDecrease
            )
        }
        .horizontalPadding()
    }
}

#Preview {
    CoffeeItemView(
        item: CoffeeItem(
            id:1,
            name: "Caffe Mocha",
            subtitle: "Deep Foam",
            price: 4.53,
            imageName: "mocha"
        ),
        quantity: 2,
        onIncrease: {},
        onDecrease: {}
    )
  //  .previewLayout(.sizeThatFits)
    .padding()
}
