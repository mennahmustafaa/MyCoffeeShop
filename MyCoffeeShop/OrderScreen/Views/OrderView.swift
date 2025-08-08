//
//  OrderView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI

struct OrderView: View {
    @StateObject private var viewModel = OrderViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView(onBackTapped: viewModel.goBack)
                
                ScrollView {
                    VStack(spacing: 20) {
                        DeliveryOptionView(selectedOption: viewModel.selectedDeliveryOption, onOptionSelected: viewModel.selectDeliveryOption)
                        
                        if viewModel.selectedDeliveryOption == .deliver {
                            DeliveryAddressView(
                                address: viewModel.deliveryAddress,
                                onEditAddress: viewModel.editAddress,
                                onAddNote: viewModel.addNote
                            )
                        }
                        
                        CoffeeItemView(
                            item: viewModel.coffeeItem,
                            quantity: viewModel.quantity,
                            onIncrease: viewModel.increaseQuantity,
                            onDecrease: viewModel.decreaseQuantity
                        )
                        
                        if viewModel.hasDiscount {
                            DiscountView(discountText: viewModel.discountText)
                        }
                        
                        PaymentSummaryView(
                            itemPrice: viewModel.itemPrice,
                            originalDeliveryFee: viewModel.originalDeliveryFee,
                            deliveryFee: viewModel.deliveryFee
                        )
                        
                        Divider().padding(.horizontal, 20)
                        
                        PaymentMethodView(
                            selectedMethod: viewModel.selectedPaymentMethod,
                            walletBalance: viewModel.walletBalance,
                            onMethodTapped: viewModel.showPaymentOptions
                        )
                        
                        Spacer(minLength: 100)
                    }
                }
                
                OrderButtonView(
                    isLoading: viewModel.isLoading,
                    onOrderTapped: viewModel.placeOrder
                )
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
        .actionSheet(isPresented: $viewModel.showingPaymentSheet) {
            ActionSheet(
                title: Text("Payment Method"),
                buttons: PaymentMethod.allCases.map { method in
                    .default(Text(method.title)) {
                        viewModel.selectPaymentMethod(method)
                    }
                } + [.cancel()]
            )
        }
    }
}

#Preview {
    OrderView()
}
