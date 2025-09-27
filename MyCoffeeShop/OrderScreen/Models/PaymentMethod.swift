//
//  PaymentMethod.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//
import Foundation
enum PaymentMethod: CaseIterable {
    case cashWallet, creditCard, digitalWallet
    
    var title: String {
        switch self {
        case .cashWallet: return "Cash/Wallet"
        case .creditCard: return "Credit Card"
        case .digitalWallet: return "Digital Wallet"
        }
    }
    
    var iconName: String {
        switch self {
        case .cashWallet: return "banknote"
        case .creditCard: return "creditcard"
        case .digitalWallet: return "wallet.pass"
        }
    }
}
