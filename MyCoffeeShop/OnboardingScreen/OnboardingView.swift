// OnboardingView.swift
import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()

    var body: some View {
        NavigationStack {
            Welcome(viewModel: viewModel)
                .navigationDestination(isPresented: $viewModel.shouldNavigateToLogin) {
                    LoginView()
                }
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
    }
}

// Preview
#Preview {
    OnboardingView()
}
