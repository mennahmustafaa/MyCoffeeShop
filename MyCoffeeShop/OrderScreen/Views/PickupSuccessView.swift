//
//  PickupSuccessView.swift
//  MyCoffeeShop
//
//  Created by Antigravity on 30/01/2026.
//

import SwiftUI

struct PickupSuccessView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartVM: CartViewModel
    var rootPresenting: Binding<Bool>?
    
    @State private var showIcon = false
    @State private var showText = false
    @State private var showButton = false
    @State private var buttonPressed = false
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Success Icon
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.1))
                    .frame(width: 120, height: 120)
                    .scaleEffect(showIcon ? 1 : 0)
                
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)
                    .scaleEffect(showIcon ? 1 : 0)
                    .rotationEffect(.degrees(showIcon ? 0 : -180))
            }
            
            // Success Message
            VStack(spacing: 12) {
                Text("Order Placed Successfully!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .opacity(showText ? 1 : 0)
                    .offset(y: showText ? 0 : 20)
                
                Text("Your order is ready for pickup")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .opacity(showText ? 1 : 0)
                    .offset(y: showText ? 0 : 20)
                
                Text("Please collect your order from the counter")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .opacity(showText ? 1 : 0)
                    .offset(y: showText ? 0 : 20)
            }
            
            Spacer()
            
            // Return to Home Button
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    buttonPressed = true
                }
                
                let impact = UIImpactFeedbackGenerator(style: .medium)
                impact.impactOccurred()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    // Clear cart
                    cartVM.clearCart()
                    
                    // Navigate to home
                    if let rootPresenting = rootPresenting {
                        rootPresenting.wrappedValue = false
                    } else {
                        dismiss()
                    }
                }
            }) {
                Text("Return to Home")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.Colors.primaryBrown)
                    .cornerRadius(14)
                    .scaleEffect(buttonPressed ? 0.95 : 1.0)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
            .opacity(showButton ? 1 : 0)
            .scaleEffect(showButton ? 1 : 0.8)
        }
        .navigationBarHidden(true)
        .onAppear {
            // Clear cart when view appears
            cartVM.clearCart()
            
            // Staggered animations
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6).delay(0.1)) {
                showIcon = true
            }
            
            withAnimation(.easeOut(duration: 0.5).delay(0.4)) {
                showText = true
            }
            
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.7)) {
                showButton = true
            }
        }
    }
}

#Preview {
    let cartVM = CartViewModel()
    
    return NavigationStack {
        PickupSuccessView()
            .environmentObject(cartVM)
    }
}
