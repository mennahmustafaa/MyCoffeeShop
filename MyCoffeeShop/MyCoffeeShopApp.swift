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
    
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted = false

    var body: some Scene {
        WindowGroup {
            Group {
                if !isOnboardingCompleted {
                    OnboardingView()
                } else if !appState.isAuthenticated {
                    LoginView()
                } else {
                    HomeView()
                }
            }
            .environmentObject(appState)
            .environmentObject(favoriteVM)
            .environmentObject(cartVM)
        }
    }
}
