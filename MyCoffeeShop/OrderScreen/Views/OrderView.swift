//
//  OrderView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI
import MapKit
import CoreLocation

struct OrderView: View {
    @StateObject private var viewModel: OrderViewModel
    @StateObject private var addressViewModel = DeliveryAddressViewModel()
    @State private var showingAddressEditor = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartVM: CartViewModel
    var rootPresenting: Binding<Bool>? // Optional binding for pop to root
    
    init(cartItems: [CartItem] = [], rootPresenting: Binding<Bool>? = nil) {
        _viewModel = StateObject(wrappedValue: OrderViewModel(cartItems: cartItems))
        self.rootPresenting = rootPresenting
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: AppTheme.Spacing.verticalSpacing) {
                    // Header
                    HeaderView(onBackTapped: {
                        if let rootPresenting = rootPresenting {
                            rootPresenting.wrappedValue = false
                        } else {
                            dismiss()
                        }
                    })
                    
                    // Delivery Option Toggle
                    DeliveryOptionView(
                        selectedOption: viewModel.selectedDeliveryOption,
                        onOptionSelected: { option in
                            viewModel.selectDeliveryOption(option)
                        }
                    )
                    
                    // Delivery Address Section
                    if viewModel.selectedDeliveryOption == .deliver {
                        deliveryAddressSection
                    }
                    
                    // Divider
                    StandardDivider()
                        .horizontalPadding()
                    
                    // Order Items List
                    orderItemsSection
                    
                    // Discount
                    if viewModel.hasDiscount {
                        DiscountView(
                            discountText: viewModel.discountText,
                            onTap: {
                                viewModel.showingPromoSheet = true
                            }
                        )
                    }
                    
                    // Order Note Display
                    if viewModel.hasNote {
                        orderNoteSection
                    }
                    
                    // Payment Summary
                    PaymentSummaryView(
                        itemPrice: viewModel.itemsTotal,
                        originalDeliveryFee: viewModel.originalDeliveryFee,
                        deliveryFee: viewModel.deliveryFee,
                        discountAmount: viewModel.discountAmount,
                        totalAmount: viewModel.totalAmount
                    )
                    
                    // Divider
                    StandardDivider()
                        .horizontalPadding()
                    
                    // Payment Method
                    PaymentMethodView(
                        selectedMethod: viewModel.selectedPaymentMethod,
                        walletBalance: viewModel.walletBalance,
                        onMethodTapped: {
                            viewModel.showPaymentOptions()
                        }
                    )
                    
                    // Bottom padding for button
                    Spacer()
                        .frame(height: 100)
                }
                .padding(.top, 10)
            }
            
            // Order Button (Fixed at bottom)
            OrderButtonView(
                isLoading: viewModel.isLoading,
                onOrderTapped: {
                    viewModel.placeOrder()
                }
            )
        }
        .navigationBarHidden(true)
        .onAppear {
            // Reload address when view appears
            addressViewModel.objectWillChange.send()
        }
        .sheet(isPresented: $showingAddressEditor, onDismiss: {
            // Reload the address when sheet is dismissed
            let newViewModel = DeliveryAddressViewModel()
            addressViewModel.address = newViewModel.address
        }) {
            NavigationView {
                NewAddressView()
            }
        }
        .sheet(isPresented: $viewModel.showingPaymentSheet) {
            PaymentMethodSheet(
                selectedMethod: $viewModel.selectedPaymentMethod,
                onMethodSelected: { method in
                    viewModel.selectPaymentMethod(method)
                }
            )
        }
        .sheet(isPresented: $viewModel.showingNoteSheet) {
            NoteSheetView(
                note: $viewModel.orderNote,
                onSave: {
                    viewModel.saveNote()
                }
            )
        }
        .sheet(isPresented: $viewModel.showingCreditCardInput) {
            CreditCardInputView(onPaymentSuccess: {
                viewModel.completeOrder()
            })
        }
        .sheet(isPresented: $viewModel.showingPromoSheet) {
            PromoCodeSheet(
                promoCode: $viewModel.promoCode,
                onApply: {
                    viewModel.applyPromoCode()
                }
            )
            .presentationDetents([.height(250)])
        }
        .navigationDestination(isPresented: $viewModel.showingSuccessScreen) {
            DeliveryTrackingView(address: addressViewModel.address)
        }
    }
    
    // MARK: - Delivery Address Section
    private var deliveryAddressSection: some View {
        
        VStack(alignment: .leading, spacing: AppTheme.Spacing.mediumSpacing) {
            Text("Delivery Address")
                .font(AppTheme.Typography.headline())
                .horizontalPadding()
            
            VStack(alignment: .leading, spacing: AppTheme.Spacing.smallSpacing) {
                Text(viewModel.formattedLocationName(from: addressViewModel.address))
                    .font(AppTheme.Typography.body(weight: .semibold))
                
                Text(viewModel.formattedFullAddress(from: addressViewModel.address))
                    .font(AppTheme.Typography.caption())
                    .foregroundColor(AppTheme.Colors.secondaryText)
                    .lineLimit(2)
            }
            .horizontalPadding()
            
           
            
            HStack(spacing: AppTheme.Spacing.mediumSpacing) {
                ActionButton(
                    title: "Edit Address",
                    iconName: "pencil",
                    action: {
                        showingAddressEditor = true
                    }
                )
                
                ActionButton(
                    title: viewModel.hasNote ? "Edit Note" : "Add Note",
                    iconName: "note.text",
                    action: {
                        viewModel.showNoteEditor()
                    }
                )
            }
            .horizontalPadding()
        }
    }
    
    // MARK: - Order Items Section
    private var orderItemsSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.mediumSpacing) {
            ForEach(viewModel.cartItems) { item in
                OrderItemRow(
                    item: item,
                    onIncrease: { viewModel.increaseQuantity(for: item) },
                    onDecrease: { viewModel.decreaseQuantity(for: item) }
                )
            }
        }
    }
    
    // MARK: - Order Note Section
    private var orderNoteSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.smallSpacing) {
            Text("Order Note")
                .font(AppTheme.Typography.caption(weight: .semibold))
                .foregroundColor(AppTheme.Colors.secondaryText)
            
            Text(viewModel.orderNote)
                .font(AppTheme.Typography.body())
                .padding(AppTheme.Spacing.mediumSpacing)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppTheme.Colors.secondaryBackground)
                .cornerRadius(AppTheme.CornerRadius.medium)
        }
        .horizontalPadding()
    }
}

// MARK: - Order Item Row
struct OrderItemRow: View {
    let item: CartItem
    let onIncrease: () -> Void
    let onDecrease: () -> Void
    
    var body: some View {
        HStack(spacing: AppTheme.Spacing.mediumSpacing) {
            // Product Image
            Image(item.product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 54, height: 54)
                .cornerRadius(AppTheme.CornerRadius.medium)
            
            // Product Info
            VStack(alignment: .leading, spacing: 4) {
                Text(item.product.name)
                    .font(AppTheme.Typography.body(weight: .semibold))
                
                HStack(spacing: 4) {
                    Text(item.product.type)
                        .font(AppTheme.Typography.caption())
                        .foregroundColor(AppTheme.Colors.secondaryText)
                    
                    Text("•")
                        .foregroundColor(AppTheme.Colors.secondaryText)
                    
                    Text("Size: \(item.size)")
                        .font(AppTheme.Typography.caption())
                        .foregroundColor(AppTheme.Colors.primaryBrown)
                }
                
                Text(String(format: "$%.2f", item.adjustedPrice))
                    .font(AppTheme.Typography.caption(weight: .semibold))
                    .foregroundColor(AppTheme.Colors.primaryBrown)
            }
            
            Spacer()
            
            // Quantity Controls
            HStack(spacing: AppTheme.Spacing.smallSpacing) {
                Button(action: onDecrease) {
                    Image(systemName: "minus")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(item.quantity > 1 ? AppTheme.Colors.primaryBrown : AppTheme.Colors.secondaryText)
                        .frame(width: 28, height: 28)
                        .background(Circle().fill(AppTheme.Colors.secondaryBackground))
                }
                .disabled(item.quantity <= 1)
                
                Text("\(item.quantity)")
                    .font(AppTheme.Typography.body(weight: .semibold))
                    .frame(minWidth: 24)
                
                Button(action: onIncrease) {
                    Image(systemName: "plus")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 28, height: 28)
                        .background(Circle().fill(AppTheme.Colors.primaryBrown))
                }
            }
        }
        .horizontalPadding()
    }
}

#Preview {
    let cartVM = CartViewModel()
    let favVM = FavoriteViewModel()
    let mockProduct = ProductDetailItem(id: 1, name: "Caffe Mocha", type: "Hot", description: "", price: 4.53, imageName: "mocha")
    cartVM.addToCart(product: mockProduct, size: "M")
    
    return OrderView(cartItems: cartVM.cartItems)
        .environmentObject(cartVM)
        .environmentObject(favVM)
}
