import SwiftUI

struct LocationHeaderView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    @EnvironmentObject var appState: AppState
    @Binding var showLocationPicker: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background with Gradient
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity)
                .frame(height: 280) // Keep height to accommodate banner
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.07, green: 0.07, blue: 0.07), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.19, green: 0.19, blue: 0.19), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 1, y: 0),
                        endPoint: UnitPoint(x: 0, y: 1)
                    )
                )
                .ignoresSafeArea(edges: .top)
            
            VStack(alignment: .leading, spacing: 16) {
                // Top Row: Location & Sign Out
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Location")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Button {
                            showLocationPicker = true
                        } label: {
                            HStack(spacing: 4) {
                                Text(locationViewModel.currentLocation.displayName)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                
                                Image(systemName: "chevron.down")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        appState.signOut()
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 60) // Add top padding to account for status bar/safe area since we ignore safe area
                
                // Banner Image
                Image("Banner")
                    .resizable()
                    .scaledToFill() // Ensure it fills the frame nicely
                    .frame(height: 140)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
        }
        .frame(height: 280) // Explicit height for the whole header component
    }
}

#Preview {
    let locationVM = LocationViewModel()
    let appState = AppState()
    
    return LocationHeaderView(
        locationViewModel: locationVM,
        showLocationPicker: .constant(false)
    )
    .environmentObject(appState)
}
