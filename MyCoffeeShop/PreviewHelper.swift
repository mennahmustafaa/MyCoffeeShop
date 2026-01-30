//
//  PreviewHelper.swift
//  MyCoffeeShop
//
//  Created by Mennah on 21/07/2025.
//

import SwiftUI

/// A helper to allow previewing views with @Binding values.
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    let content: (Binding<Value>) -> Content

    init(_ initialValue: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
