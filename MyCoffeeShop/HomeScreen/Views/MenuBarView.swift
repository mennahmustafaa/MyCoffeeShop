import SwiftUI

struct MenuBarView: View {
    @ObservedObject var viewModel: CoffeeListViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                menuButton(title: "All")

                ForEach(viewModel.coffeeItems, id: \.id) { coffee in
                    menuButton(title: coffee.name)
                }
            }
            .padding(.horizontal)
        }
    }

    private func menuButton(title: String) -> some View {
        Button(action: {
          //  viewModel.selectCoffee(title) // ✅ Use without $
        }) {
            Text(title)
                .foregroundColor(viewModel.selectedCoffee == title ? .orange : .gray)
                .fontWeight(viewModel.selectedCoffee == title ? .bold : .regular)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
        }
    }
}

#Preview {
    let viewModel = CoffeeListViewModel()
    return MenuBarView(viewModel: viewModel)
}

