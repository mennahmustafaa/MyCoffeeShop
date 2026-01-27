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
                    .fill(AppTheme.Colors.darkGray)
            )

            Image(systemName: "slider.horizontal.3")
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AppTheme.Colors.primaryBrown)
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
