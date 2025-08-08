//
//  PageInfo.swift
//  MyCoffeeShop
//
//  Created by Mennah on 22/07/2025.
//

// OnboardingViewModel.swift
import Foundation
import SwiftUI


// PageInfo.swift
import SwiftUI

struct PageInfo: Identifiable {
    let id = UUID()
    let label: String
    let text: String
    let image: ImageResource
    let bottomImage: ImageResource
}

let pages: [PageInfo] = [
    PageInfo(
        label: "Fall in Love with\nCoffee in Blissful\nDelight!",
        text: "Welcome to our cozy coffee corner, where every cup is delightful for you.",
        image: .onboarding,
        bottomImage: .iphone
    )
]
