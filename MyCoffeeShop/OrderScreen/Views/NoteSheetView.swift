//
//  NoteSheetView.swift
//  MyCoffeeShop
//
//  Order note input sheet
//

import SwiftUI

struct NoteSheetView: View {
    @Binding var note: String
    let onSave: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: AppTheme.Spacing.verticalSpacing) {
                Text("Add a note for your order")
                    .font(AppTheme.Typography.body())
                    .foregroundColor(AppTheme.Colors.secondaryText)
                    .padding(.top)
                
                TextEditor(text: $note)
                    .frame(minHeight: 150)
                    .padding(AppTheme.Spacing.mediumSpacing)
                    .background(AppTheme.Colors.secondaryBackground)
                    .cornerRadius(AppTheme.CornerRadius.medium)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                            .stroke(AppTheme.Colors.divider, lineWidth: 1)
                    )
                
                Text("E.g., Extra sugar, no ice, leave at door...")
                    .font(AppTheme.Typography.caption())
                    .foregroundColor(AppTheme.Colors.secondaryText)
                
                Spacer()
                
                Button {
                    onSave()
                    dismiss()
                } label: {
                    Text("Save Note")
                        .font(AppTheme.Typography.headline())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(AppTheme.Colors.primaryBrown)
                        .cornerRadius(AppTheme.CornerRadius.extraLarge)
                }
            }
            .horizontalPadding()
            .navigationTitle("Order Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(AppTheme.Colors.primaryBrown)
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    @Previewable @State var note = ""
    NoteSheetView(note: $note, onSave: {})
}
