//
//  DeliveryAdressView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI

struct DeliveryAddressView: View {
    let address: DeliveryAddress
    let onEditAddress: () -> Void
    let onAddNote: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Delivery Address")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
            }

            Text(address.title)
                .font(.system(size: 14, weight: .semibold))

            Text(address.fullAddress)
                .font(.system(size: 12))
                .foregroundColor(.gray)

            HStack(spacing: 15) {
                ActionButton(
                    title: "Edit Address",
                    iconName: "pencil",
                    action: onEditAddress
                )

                ActionButton(
                    title: "Add Note",
                    iconName: "note.text",
                    action: onAddNote
                )

                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    DeliveryAddressView(
        address: DeliveryAddress(
            title: "Jl. Kpg Sutoyo",
            fullAddress: "Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai."
        ),
        onEditAddress: {},
        onAddNote: {}
    )
    //.previewLayout(.sizeThatFits)
    .padding()
}
