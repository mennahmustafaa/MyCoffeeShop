// OnboardingView.swift
import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @Binding var isOnboardingCompleted: Bool

    var body: some View {
        Welcome(viewModel: viewModel) {
            print("Get Started tapped - setting isOnboardingCompleted = true")
            isOnboardingCompleted = true
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
    }
}

// Preview
#Preview {
    OnboardingView(isOnboardingCompleted: .constant(false))
}
