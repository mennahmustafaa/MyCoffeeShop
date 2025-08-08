import SwiftUI
struct CoffeeGridView: View {
    @ObservedObject var viewModel: CoffeeListViewModel
    var onProductTap: ((CoffeeItem) -> Void)? = nil

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
       
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.finalFilteredItems) { item in
                    CoffeeCardView(item: item)
                        .onTapGesture {
                            onProductTap?(item)
                        }
                }
            }
            .padding()
        
    }
}
