//
//  ActionButtonView.swift
//  MyCoffeeShop
//
//  Created by Mennah on 28/07/2025.
//

import SwiftUI


struct ActionButton: View {
    let title: String
    let iconName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: iconName)
                    .font(AppTheme.Typography.caption())
                Text(title)
                    .font(AppTheme.Typography.caption())
            }
        }
        .secondaryButtonStyle()
    }
}


#Preview {
    ActionButton(title: "Edit Address", iconName: "pencil", action: {})
       // .previewLayout(.sizeThatFits)
        .padding()
}
