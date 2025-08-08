//
//  EmailVerficationViewModel.swift
//  MyCoffeeShop
//
//  Created by Mennah on 25/07/2025.
//

import Foundation
import FirebaseAuth

class EmailVerificationViewModel: ObservableObject {
    @Published var isSent = false
    @Published var errorMessage: String?
    @Published var isVerified = false

    func sendVerificationEmail() {
        guard let user = Auth.auth().currentUser else {
            errorMessage = "No user is logged in."
            return
        }

        if user.isEmailVerified {
            isVerified = true
            return
        }

        user.sendEmailVerification { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.isSent = true
                }
            }
        }
    }

    func checkVerificationStatus() {
        Auth.auth().currentUser?.reload(completion: { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.isVerified = Auth.auth().currentUser?.isEmailVerified ?? false
                }
            }
        })
    }
}
