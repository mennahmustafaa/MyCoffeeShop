import SwiftUI

struct MenuBarView: View {
    @ObservedObject var viewModel: CoffeeListViewModel

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    menuButton(title: "All", proxy: proxy)

                    ForEach(viewModel.coffeeItems, id: \.id) { coffee in
                        menuButton(title: coffee.name, proxy: proxy)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private func menuButton(title: String, proxy: ScrollViewProxy) -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                viewModel.selectCoffee(title: title)
                viewModel.scrollToCoffeeID = title // Set scroll target
            }
        }) {
            Text(title)
                .foregroundColor(viewModel.selectedCoffee == title ? .orange : .gray)
                .fontWeight(viewModel.selectedCoffee == title ? .bold : .regular)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(viewModel.selectedCoffee == title ? Color.orange : Color.clear, lineWidth: 2)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(viewModel.selectedCoffee == title ? Color.orange.opacity(0.1) : Color.clear)
                        )
                )
                .scaleEffect(viewModel.selectedCoffee == title ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 0.3), value: viewModel.selectedCoffee)
        }
        .buttonStyle(PlainButtonStyle())
        .id(title)
    }
}

#Preview {
    let viewModel = CoffeeListViewModel()
    return MenuBarView(viewModel: viewModel)
}

