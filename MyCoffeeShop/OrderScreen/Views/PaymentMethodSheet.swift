//
//  PaymentMethodSheet.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI

struct PaymentMethodSheet: View {
    @Binding var selectedMethod: PaymentMethod
    let onMethodSelected: (PaymentMethod) -> Void
    @Environment(\.dismiss) var dismiss
    
    // Local state to track selection before confirming
    @State private var tempSelectedMethod: PaymentMethod
    
    init(selectedMethod: Binding<PaymentMethod>, onMethodSelected: @escaping (PaymentMethod) -> Void) {
        self._selectedMethod = selectedMethod
        self.onMethodSelected = onMethodSelected
        self._tempSelectedMethod = State(initialValue: selectedMethod.wrappedValue)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 4)
                .padding(.top, 10)
            
            Text("Payment Method")
                .font(.headline)
            
            VStack(spacing: 16) {
                ForEach(PaymentMethod.allCases, id: \.self) { method in
                    Button(action: {
                        tempSelectedMethod = method
                    }) {
                        HStack {
                            Image(systemName: method.iconName)
                                .foregroundColor(.black)
                                .frame(width: 24)
                            
                            Text(method.title)
                                .foregroundColor(.black)
                                .font(.body)
                            
                            Spacer()
                            
                            Image(systemName: tempSelectedMethod == method ? "record.circle" : "circle")
                                .foregroundColor(tempSelectedMethod == method ? .brown : .gray)
                                .font(.system(size: 20))
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                selectedMethod = tempSelectedMethod
                onMethodSelected(tempSelectedMethod)
                dismiss()
            }) {
                Text("Confirm")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown)
                    .cornerRadius(14)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    @Previewable @State var selectedMethod: PaymentMethod = .cash
    
    PaymentMethodSheet(
        selectedMethod: $selectedMethod,
        onMethodSelected: { _ in }
    )
}
