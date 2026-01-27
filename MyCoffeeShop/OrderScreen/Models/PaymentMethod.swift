//
//  PaymentMethod.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//
import Foundation
enum PaymentMethod: CaseIterable {
    case applePay, visa, cash
    
    var title: String {
        switch self {
        case .applePay: return "Apple Pay"
        case .visa: return "Visa"
        case .cash: return "Cash"
        }
    }
    
    var iconName: String {
        switch self {
        case .applePay: return "apple.logo"
        case .visa: return "creditcard.fill"
        case .cash: return "banknote.fill"
        }
    }
}
