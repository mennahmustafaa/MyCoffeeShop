import SwiftUI
struct CoffeeGridView: View {
    @ObservedObject var viewModel: CoffeeListViewModel
    var onProductTap: ((CoffeeItem) -> Void)? = nil
    var onAddToCart: ((CoffeeItem) -> Void)? = nil

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
       
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Array(viewModel.finalFilteredItems.enumerated()), id: \.element.id) { index, item in
                    CoffeeCardView(item: item, onAddToCart: {
                        onAddToCart?(item)
                    })
                        .staggeredFadeIn(index: index, delay: 0.08)
                        .onTapGesture {
                            onProductTap?(item)
                        }
                }
            }
            .padding()
        
    }
}

