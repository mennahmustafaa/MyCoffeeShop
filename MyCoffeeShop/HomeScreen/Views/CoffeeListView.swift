//
//  CoffeeListView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/06/2025.
//

import SwiftUI

struct CoffeeCardView: View {
    let item: CoffeeItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // Image section with conditional logic for "matcha"
            if item.imageName == "matcha" {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 134)
                    .background(Color(hex: "#2A2A2A")) // match theme
                    .cornerRadius(16)
                    .clipped()
                    .padding(10)
                    .offset(y:-10)
                    
                
            } else {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 128)
                    .cornerRadius(16)
                    .clipped()
                
            }

            // Name and rating section
            HStack {
                Text(item.name)
                    .font(.headline)

                Spacer()

                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }

            // Subtitle
            Text(item.subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)

            // Price and add button
            HStack {
                Text("$\(item.price, specifier: "%.2f")")
                    .font(.headline)

                Spacer()

                Button(action: {}) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color(hex: "#2A2A2A"))
                        .clipShape(Circle())
                }
            }
        }
        .padding(12)
               .background(Color.white)
               .cornerRadius(16)
               .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
           }
}

// MARK: - Preview
#Preview {
   
        CoffeeGridView(viewModel: CoffeeListViewModel())
    
}
