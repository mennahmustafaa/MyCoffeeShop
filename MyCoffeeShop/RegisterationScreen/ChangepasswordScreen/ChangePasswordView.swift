//
//  ChangePasswordView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 25/07/2025.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @StateObject private var viewModel = ChangePasswordViewModel()

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
                    .frame(height: 400)
                    .ignoresSafeArea(edges: .bottom)
            }

            VStack(spacing: 20) {
                Text("Change Password")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                secureField(title: "New Password", text: $newPassword)
                secureField(title: "Confirm Password", text: $confirmPassword)

                Button(action: {
                    guard !newPassword.isEmpty, !confirmPassword.isEmpty else {
                        viewModel.errorMessage = "Please fill in all fields."
                        return
                    }

                    guard newPassword == confirmPassword else {
                        viewModel.errorMessage = "Passwords do not match."
                        return
                    }

                    viewModel.changePassword(to: newPassword)
                }) {
                    Text("Update Password")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 250)
                        .padding()
                        .background(Color(hex: "#C67C4E"))
                        .cornerRadius(10)
                }

                if let message = viewModel.successMessage {
                    Text(message)
                        .foregroundColor(.green)
                        .font(.footnote)
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button("Back") {
                    dismiss()
                }
                .foregroundColor(.white.opacity(0.8))
            }
            .padding()
            .background(Color.white.opacity(0.05))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 1)
            )
            .frame(width: 330)
        }
    }

    private func secureField(title: String, text: Binding<String>) -> some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.white.opacity(0.7))
            SecureField("", text: text, prompt: Text(title).foregroundColor(.white.opacity(0.6)))
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 300, height: 50)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 1)
        )
    }
}
#Preview {
    ChangePasswordView()
}
