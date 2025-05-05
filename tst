import SwiftUI

struct LocationHeaderView: View {
    @StateObject private var viewModel = LocationViewModel()
    @State private var showLocationPicker = false

    var body: some View {
        ZStack {
            Color.black
                .frame(width: 420, height: 350)
                .offset(y: -350)

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Location")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .offset(x: 25, y: -350)
                    
                }
                
                HStack{
                    Button(action: {
                        showLocationPicker = true
                    }) {
                        HStack(spacing: 4) {
                            Text(viewModel.currentLocation.displayName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Image(systemName: "chevron.down")
                                .font(.caption2)
                                .foregroundColor(Color("PrimaryColor"))
                            
                        }
                        .offset(x: -32, y: -325)
                    }
                    .sheet(isPresented: $showLocationPicker) {
                        LocationPickerView(
                            currentLocation: viewModel.currentLocation,
                            availableLocations: viewModel.availableLocations,
                            onLocationSelected: { location in
                                viewModel.updateLocation(location)
                            },
                            isPresented: $showLocationPicker
                        )
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 4)
            .background(Color.red)
        }
    }
}

#Preview {
    LocationHeaderView()
}
