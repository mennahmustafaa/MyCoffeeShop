
//
//  BottomToolbarView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 06/09/2025.
//


import SwiftUI

struct BottomToolbarView: View {
    @ObservedObject var viewModel: ToolbarViewModel
    
    var body: some View {

     VStack(spacing: 0) {

        // Main toolbar content
        VStack(spacing: 0) {
            // Top section with main navigation icons

            HStack(spacing: 50) {
                
                // Home button
                Button(action: { viewModel.select(tab: "home") }) {
                    VStack(spacing: 4) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 24))
                            .scaleEffect(viewModel.selectedTab == "home" ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.2), value: viewModel.selectedTab)
                            .foregroundColor(viewModel.selectedTab == "home" ? .orange : .gray)
                    }
                }
                
                // Favorites button
                Button(action: { viewModel.select(tab: "favorites") }) {
                    VStack(spacing: 4) {
                        Image(systemName: "heart")
                            .font(.system(size: 24))
                            .scaleEffect(viewModel.selectedTab == "favorites" ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.2), value: viewModel.selectedTab)
                            .foregroundColor(viewModel.selectedTab == "favorites" ? .orange : .gray)
                    }
                }
                
                // Cart button
                Button(action: { viewModel.select(tab: "cart") }) {
                    VStack(spacing: 4) {
                        Image(systemName: "cart")
                            .font(.system(size: 24))
                            .scaleEffect(viewModel.selectedTab == "cart" ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.2), value: viewModel.selectedTab)
                            .foregroundColor(viewModel.selectedTab == "cart" ? .orange : .gray)
                    }
                }
                
                // Notification button
                Button(action: { viewModel.select(tab: "notifications") }) {
                    VStack(spacing: 4) {
                        Image(systemName: "bell")
                            .font(.system(size: 24))
                            .scaleEffect(viewModel.selectedTab == "notifications" ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.2), value: viewModel.selectedTab)
                            .foregroundColor(viewModel.selectedTab == "notifications" ? .orange : .gray)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)

        }
        .cornerRadius(25, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
        .frame(maxWidth: .infinity)

                    }
      //  .background(Color.white) // White background for toolbar only
        .cornerRadius(25, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
        .frame(maxWidth: .infinity)


    }
}

// Extension to add corner radius to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    BottomToolbarView(viewModel: ToolbarViewModel())
        .padding()
}



