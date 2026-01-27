import SwiftUI

struct PaymentSuccessView: View {
    var onGoHome: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text("Payment Successful!")
                .font(.title2)
                .bold()
            
            Text("Your order has been placed successfully.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(action: onGoHome) {
                Text("Back to Home")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown)
                    .cornerRadius(14)
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    PaymentSuccessView(onGoHome: {})
}
