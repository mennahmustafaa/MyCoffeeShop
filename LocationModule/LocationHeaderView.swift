import SwiftUI

struct LocationHeaderView: View {
    @StateObject private var viewModel = LocationViewModel()
    @State private var showLocationPicker = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black
                .frame(height: 200)
                .edgesIgnoringSafeArea(.top)
                .offset(y:-290)
            VStack(alignment: .leading, spacing: 4) {
                Text("Location")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Button(action: {
                    showLocationPicker = true
                }) {
                    HStack(spacing: 4) {
                        Text(viewModel.currentLocation.displayName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                        
                        Image(systemName: "chevron.down")
                            .font(.caption2)
                            .foregroundColor(Color.gray)
                         
                    }
                    
                }
                
                
            }
            .offset(y:-340)
            .padding(.top, 60)
            .padding(.leading, 5)
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
}

#Preview {
    LocationHeaderView()
}

