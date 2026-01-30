//
//  OnboardingViewModel.swift
//  MyCoffeeShop
//
//  Created by Mennah on 22/07/2025.
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var shouldNavigateToLogin: Bool = false
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted = false

    func completeOnboarding() {
        print("OnboardingViewModel: completeOnboarding called")
        withAnimation {
            isOnboardingCompleted = true
        }
        // AppState in MyCoffeeShopApp will detect this change and switch to LoginView
    }
}
