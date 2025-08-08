//
//  EmailVerficationView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 25/07/2025.
//

import SwiftUI

struct EmailVerificationView: View {
    @StateObject private var viewModel = EmailVerificationViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Image("onboarding")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.black)
                    .opacity(1)
                    .frame(height: 400)
                    .ignoresSafeArea()
            }

            VStack(spacing: 20) {
                Text("Verify Your Email")
                    .font(.title2).bold()
                    .foregroundColor(.white)

                Text("We’ve sent a verification email to your inbox.\nPlease click the link to activate your account.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(width: 300)

                if viewModel.isSent {
                    Text("✅ Email sent successfully.")
                        .foregroundColor(.green)
                        .font(.subheadline)
                }

                Button("Resend Email") {
                    viewModel.sendVerificationEmail()
                }
                .frame(width: 250)
                .padding()
                .background(Color(hex: "#C67C4E"))
                .cornerRadius(10)
                .foregroundColor(.white)

                Button("Check Verification") {
                    viewModel.checkVerificationStatus()
                }
                .foregroundColor(.white.opacity(0.9))

                Button("Back") {
                    dismiss()
                }
                .foregroundColor(.white.opacity(0.7))
            }
            .padding()
            .background(Color.white.opacity(0.05))
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
            .frame(width: 330)
        }
        .alert("Verified!", isPresented: $viewModel.isVerified) {
            Button("Go to Home", role: .cancel) {
                // You can navigate to HomeView here
            }
        } message: {
            Text("Your email is verified! 🎉")
        }
        .onAppear {
            viewModel.sendVerificationEmail()
        }
    }
}

#Preview {
    EmailVerificationView()
}
