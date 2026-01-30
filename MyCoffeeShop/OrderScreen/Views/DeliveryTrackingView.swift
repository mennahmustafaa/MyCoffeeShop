//
//  DeliveryTrackingView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 04/12/2025.
//

import SwiftUI
import MapKit

struct DeliveryTrackingView: View {
    @StateObject private var viewModel: DeliveryTrackingViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartVM: CartViewModel
    var rootPresenting: Binding<Bool>?
    
    init(address: DeliveryAddress, rootPresenting: Binding<Bool>? = nil) {
        _viewModel = StateObject(wrappedValue: DeliveryTrackingViewModel(address: address))
        self.rootPresenting = rootPresenting
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Map Layer
            // Map Layer
            Map {
                // Courier Marker
                Annotation("Courier", coordinate: viewModel.courierLocation) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 40, height: 40)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                        
                        Image(systemName: "bicycle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                }
                
                // Destination Marker
                Annotation("Destination", coordinate: CLLocationCoordinate2D(latitude: viewModel.deliveryAddress.latitude, longitude: viewModel.deliveryAddress.longitude)) {
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.orange)
                        .background(Circle().fill(.white).frame(width: 20, height: 20))
                        .shadow(radius: 2)
                }
                
                // Route Polyline
                if let route = viewModel.route {
                    MapPolyline(route)
                        .stroke(AppTheme.Colors.accent, lineWidth: 4)
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            // Top Controls
            VStack {
                HStack {
                    Button(action: {
                        // Clear cart and navigate home
                        cartVM.clearCart()
                        if let rootPresenting = rootPresenting {
                            rootPresenting.wrappedValue = false
                        } else {
                            dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 45, height: 45)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Recenter map action
                    }) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 45, height: 45)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 60) // Adjust for safe area
                
                Spacer()
            }
            
            // Bottom Sheet
            VStack(spacing: 24) {
                // Handle bar
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 40, height: 4)
                    .padding(.top, 12)
                
                // Time and Address
                VStack(spacing: 8) {
                    Text(viewModel.deliveryStatus)
                        .font(.title3)
                        .bold()
                    
                    Text("Delivery to \(viewModel.formattedAddress)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Progress Bars
                HStack(spacing: 8) {
                    ForEach(0..<4) { index in
                        Capsule()
                            .fill(index < 3 ? Color.green : Color.gray.opacity(0.3)) // Mock progress
                            .frame(height: 4)
                    }
                }
                .padding(.horizontal)
                
                // Status Card
                HStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "box.truck.badge.clock.fill") // Placeholder icon
                            .foregroundColor(.orange)
                            .font(.title2)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Delivered your order")
                            .font(.headline)
                        
                        Text("We will deliver your goods to you in the shortest possible time.")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .padding(.horizontal)
                
                // Courier Info
                HStack {
                    Image(systemName: "person.crop.circle.fill") // Fallback to system image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.courierName)
                            .font(.headline)
                        
                        Text(viewModel.courierRole)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Call action
                    }) {
                        Image(systemName: "phone")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.1), radius: 10, y: -5)
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onAppear {
            // Clear cart when tracking view appears
            cartVM.clearCart()
        }
    }
}





#Preview {
    let cartVM = CartViewModel()
    return DeliveryTrackingView(address: DeliveryAddress(area: "Cairo", locationName: "Home", buildingName: "Nile City Towers", latitude: 30.0, longitude: 31.0))
        .environmentObject(cartVM)
}
