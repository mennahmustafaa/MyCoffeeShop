//
//  CoffeeListView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/06/2025.
//

import SwiftUI

struct CoffeeCardView: View {
    let item: CoffeeItem
    var onAddToCart: (() -> Void)? = nil
    @State private var buttonPressed = false

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if item.imageName == "matcha" {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 134)
                        .background(AppTheme.Colors.darkGray)
                    .cornerRadius(16)
                    .clipped()
                    .padding(10)
                    .offset(y: -10)
            } else {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 128)
                    .cornerRadius(16)
                    .clipped()
            }

            HStack {
                Text(item.name)
                    .font(.headline)

                Spacer()


            }

            Text(item.subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)

            HStack {
                Text("$\(item.price, specifier: "%.2f")")
                    .font(.headline)

                Spacer()

                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                        buttonPressed = true
                    }
                    
                    // Haptic feedback
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            buttonPressed = false
                        }
                    }
                    
                    onAddToCart?()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(8)
                            .background(AppTheme.Colors.darkGray)
                        .clipShape(Circle())
                        .scaleEffect(buttonPressed ? 1.2 : 1.0)
                }
            }
        }
        .padding(12)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Preview
#Preview {
   
        CoffeeGridView(viewModel: CoffeeListViewModel())
    
}

