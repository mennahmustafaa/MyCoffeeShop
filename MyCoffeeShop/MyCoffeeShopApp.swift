//
//  MyCoffeeShopApp.swift
//  MyCoffeeShop
//
//  Created by Mennah on 03/12/2025.
//

import SwiftUI

@main
struct MyCoffeeShopApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var favoriteVM = FavoriteViewModel()
    @StateObject private var cartVM = CartViewModel()
    
    @State private var isOnboardingCompleted = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if !isOnboardingCompleted {
                    OnboardingView(isOnboardingCompleted: $isOnboardingCompleted)
                } else if !appState.isAuthenticated {
                    LoginView()
                } else {
                    HomeView()
                }
            }
            .environmentObject(appState)
            .environmentObject(favoriteVM)
            .environmentObject(cartVM)
            .onOpenURL { url in
                Task {
                    do {
                        try await SupabaseService.shared.handleDeepLink(url: url)
                        // After successful email confirmation, update auth state
                        await MainActor.run {
                            appState.isAuthenticated = true
                        }
                    } catch {
                        print("Deep link error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
