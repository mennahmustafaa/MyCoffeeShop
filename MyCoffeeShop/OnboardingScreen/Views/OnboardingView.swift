// OnboardingView.swift
import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var favoriteVM: FavoriteViewModel

    var body: some View {
        NavigationStack {
            Welcome(viewModel: viewModel)
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
    }
}

// Preview
#Preview {
    OnboardingView()
}
