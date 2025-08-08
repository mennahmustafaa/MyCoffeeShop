//
//  DeliveryOption.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//
import SwiftUI

struct DeliveryOptionView: View {
    let selectedOption: DeliveryOption
    let onOptionSelected: (DeliveryOption) -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(DeliveryOption.allCases, id: \ .self) { option in
                    Button(action: {
                        onOptionSelected(option)
                    }) {
                        Text(option.title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(selectedOption == option ? .white : .gray)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(selectedOption == option ? Color(hex:"#C67C4E") : Color.clear)
                    }
                }
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

#Preview {
    DeliveryOptionView(selectedOption: .deliver, onOptionSelected: { _ in })
      //  .previewLayout(.sizeThatFits)
        .padding()
}
