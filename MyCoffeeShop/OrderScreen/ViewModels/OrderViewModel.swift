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
    @Published var selectedPaymentMethod: PaymentMethod = .cash
    @Published var showingPaymentSheet = false
    @Published var showingNoteSheet = false
    @Published var showingPromoSheet = false
    @Published var isLoading = false
    
    // Cart items from checkout
    @Published var cartItems: [CartItem] = []
    
    // Order note
    @Published var orderNote: String = ""
    private let noteStorageKey = "savedOrderNote"
    
    // Promo Code
    @Published var promoCode: String = ""
    @Published var discountAmount: Double = 0.0
    
    private let baseDeliveryFee: Double = 2.0
    private let discountedDeliveryFee: Double = 1.0
    private let discountCount: Int = 1
    
    // MARK: - Computed Properties
    var itemsTotal: Double {
        cartItems.reduce(0) { total, item in
            total + (item.adjustedPrice * Double(item.quantity))
        }
    }
    
    var deliveryFee: Double { selectedDeliveryOption == .deliver ? discountedDeliveryFee : 0.0 }
    var originalDeliveryFee: Double { selectedDeliveryOption == .deliver ? baseDeliveryFee : 0.0 }
    var totalAmount: Double { itemsTotal + deliveryFee - discountAmount }
    var hasDiscount: Bool { discountCount > 0 || discountAmount > 0 }
    var discountText: String {
        if discountAmount > 0 {
            return "Promo Code Applied: -$\(String(format: "%.2f", discountAmount))"
        }
        return "\(discountCount) Discount\(discountCount > 1 ? "s" : "") Applied"
    }
    var walletBalance: String { String(format: "$ %.2f", totalAmount) }
    var hasNote: Bool { !orderNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    
    // MARK: - Initialization
    init(cartItems: [CartItem] = []) {
        self.cartItems = cartItems
        loadNote()
    }
    
    // MARK: - Delivery Address Formatting
    func formattedLocationName(from address: DeliveryAddress) -> String {
        address.locationName.isEmpty ? "Jl. Kpg Sutoyo" : address.locationName
    }
    
    func formattedFullAddress(from address: DeliveryAddress) -> String {
        if address.buildingName.isEmpty {
            return "Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai."
        } else {
            return "\(address.buildingName), \(address.area)"
        }
    }
    
    // MARK: - Quantity Management
    func increaseQuantity(for item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index].quantity += 1
        }
    }
    
    func decreaseQuantity(for item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            if cartItems[index].quantity > 1 {
                cartItems[index].quantity -= 1
            }
        }
    }
    
    // MARK: - Actions
    func selectDeliveryOption(_ option: DeliveryOption) { selectedDeliveryOption = option }
    
    func selectPaymentMethod(_ method: PaymentMethod) {
        selectedPaymentMethod = method
        showingPaymentSheet = false
    }
    
    func showPaymentOptions() { showingPaymentSheet = true }
    
    func showNoteEditor() { showingNoteSheet = true }
    
    func saveNote() {
        UserDefaults.standard.set(orderNote, forKey: noteStorageKey)
        showingNoteSheet = false
    }
    
    func loadNote() {
        orderNote = UserDefaults.standard.string(forKey: noteStorageKey) ?? ""
    }

    @Published var showingCreditCardInput = false
    @Published var showingSuccessScreen = false

    func placeOrder() {
        if selectedPaymentMethod == .visa {
            showingCreditCardInput = true
        } else {
            // Simulate processing for other methods
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isLoading = false
                self.completeOrder()
            }
        }
    }
    
    func completeOrder() {
        // Clear note after order
        self.orderNote = ""
        UserDefaults.standard.removeObject(forKey: self.noteStorageKey)
        self.showingSuccessScreen = true
    }
    
    func applyPromoCode() {
        if promoCode.uppercased() == "MENNAH21" {
            discountAmount = itemsTotal * 0.05
        } else {
            discountAmount = 0.0
        }
    }
}

