import SwiftUI

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: CoffeeListViewModel

    var body: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)

                ZStack(alignment: .leading) {
                    if viewModel.searchText.isEmpty {
                        Text("Search coffee")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.subheadline)
                    }

                    TextField("", text: $viewModel.searchText)
                        .font(.subheadline)
                        .disableAutocorrection(true)
                        .foregroundColor(.white)
                }
            }
            .padding(16)
            .frame(width: 270, height: 52)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: "#2A2A2A"))
            )

            Image(systemName: "slider.horizontal.3")
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: "#C67C4E"))
                )
                .foregroundColor(.white)
        }
        .padding(.horizontal)
    }
}


#Preview {
    let viewModel = CoffeeListViewModel()
    SearchView(viewModel: viewModel)
}
