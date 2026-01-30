import SwiftUI

struct HeaderView: View {
    let onBackTapped: () -> Void

    var body: some View {
        HStack {
            Button(action: onBackTapped) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .font(.title2)
            }

            Spacer()

            Text("Order")
                .font(.title2)
                .fontWeight(.semibold)

            Spacer()

            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.clear)
                    .font(.title2)
            }
        }
        .horizontalPadding()
        .padding(.top, 10)
    }
}

#Preview {
    HeaderView(onBackTapped: {})
       // .previewLayout(.sizeThatFits)
        .padding()
}

