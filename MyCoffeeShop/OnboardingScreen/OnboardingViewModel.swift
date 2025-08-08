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

    func completeOnboarding() {
        shouldNavigateToLogin = true
    }
}
