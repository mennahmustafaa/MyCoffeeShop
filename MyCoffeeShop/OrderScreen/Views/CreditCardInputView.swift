import SwiftUI

struct CreditCardInputView: View {
    @Environment(\.dismiss) var dismiss
    var onPaymentSuccess: () -> Void
    
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Card Details")
                .font(.headline)
                .padding(.top)
            
            VStack(spacing: 15) {
                TextField("Card Number", text: $cardNumber)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                HStack(spacing: 15) {
                    TextField("MM/YY", text: $expiryDate)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    TextField("CVV", text: $cvv)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                // Simulate processing delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    dismiss()
                    onPaymentSuccess()
                }
            }) {
                Text("Pay Now")
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
    CreditCardInputView(onPaymentSuccess: {})
}
