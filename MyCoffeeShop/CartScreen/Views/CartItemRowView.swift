//
//  CartItemRow.swift
//  MyCoffeeShop
//
//  Created by Mennah on 29/09/2025.
//

import SwiftUI

struct CartItemRow: View {
    let item: CartItem
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        HStack(spacing: 16) {
            Image(item.product.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(12)
                .clipped()

            VStack(alignment: .leading, spacing: 6) {
                Text(item.product.name)
                    .font(.headline)

                Text(item.product.type + " • Size: \(item.size)")
                    .foregroundColor(.gray)
                    .font(.subheadline)

                Text("$\(String(format: "%.2f", item.product.price))")
                    .foregroundColor(.brown)
                    .font(.subheadline)
            }

            Spacer()

            // Quantity control
            HStack(spacing: 8) {
                Button(action: {
                    cartVM.decreaseQuantity(for: item)
                }) {
                    Image(systemName: "minus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.brown)
                        .padding(6)
                }

                Text("\(item.quantity)")
                    .font(.subheadline)
                    .frame(minWidth: 20)

                Button(action: {
                    cartVM.increaseQuantity(for: item)
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.brown)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
