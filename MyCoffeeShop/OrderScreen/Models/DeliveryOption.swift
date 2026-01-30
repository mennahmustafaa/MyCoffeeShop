//
//  DeliveryOption.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//
import Foundation

enum DeliveryOption: CaseIterable {
    case deliver, pickup
    
    var title: String {
        switch self {
        case .deliver: return "Deliver"
        case .pickup: return "Pick Up"
        }
    }
}
