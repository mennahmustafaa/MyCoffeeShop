//
//  OrderViewModel.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//
import Foundation
import SwiftUI

class OrderViewModel: ObservableObject {
    @Published var selectedDeliveryOption: DeliveryOption = .deliver
    @Published var quantity: Int = 1
    @Published var selectedPaymentMethod: PaymentMethod = .cashWallet
    @Published var showingPaymentSheet = false
    @Published var isLoading = false

    let coffeeItem = CoffeeItem(id: 1, name: "mocha", subtitle: "mocha", price: 1.2, imageName: "mocha")
    let deliveryAddress = DeliveryAddress(title: "Jl. Kpg Sutoyo", fullAddress: "Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.")

    private let baseDeliveryFee: Double = 2.0
    private let discountedDeliveryFee: Double = 1.0
    private let discountCount: Int = 1

    var itemPrice: Double { coffeeItem.price * Double(quantity) }
    var deliveryFee: Double { selectedDeliveryOption == .deliver ? discountedDeliveryFee : 0.0 }
    var originalDeliveryFee: Double { selectedDeliveryOption == .deliver ? baseDeliveryFee : 0.0 }
    var totalAmount: Double { itemPrice + deliveryFee }
    var hasDiscount: Bool { discountCount > 0 }
    var discountText: String { "\(discountCount) Discount is Applies" }
    var walletBalance: String { String(format: "$ %.2f", totalAmount) }

    func increaseQuantity() { quantity += 1 }
    func decreaseQuantity() { if quantity > 1 { quantity -= 1 } }
    func selectDeliveryOption(_ option: DeliveryOption) { selectedDeliveryOption = option }
    func selectPaymentMethod(_ method: PaymentMethod) {
        selectedPaymentMethod = method
        showingPaymentSheet = false
    }
    func showPaymentOptions() { showingPaymentSheet = true }

    func placeOrder() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            print("Order placed successfully!")
        }
    }

    func editAddress() {
        print("Edit address tapped")
    }

    func addNote() {
        print("Add note tapped")
    }

    func goBack() {
        print("Back button tapped")
    }
}

