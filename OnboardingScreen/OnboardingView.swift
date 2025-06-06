import SwiftUI

struct ContentView: View {
    var body: some View {
        Welcome()
    }
}

struct PageInfo: Identifiable {
    let id = UUID()
    let label: String
    let text: String
    let image: ImageResource
    let bottomImage: ImageResource
}

let pages: [PageInfo] = [
    PageInfo(label: "Fall in Love with\nCoffee in Blissful\nDelight!",
             text: "welcome to our cozy coffee corner, where every cup is delightful for you.",
             image: .onboarding,
             bottomImage: .iphone)
]

struct Welcome: View {
    @State private var isNavigating = false
    
    var body: some View {
        NavigationStack {  
            VStack(spacing: 0) {
                TabView {
                    ForEach(pages) { page in
                        VStack(spacing: 0) {
                            
                            Image(page.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.712)
                                .clipped()
                                .ignoresSafeArea(.all, edges: .top)

                            
                            VStack(spacing: 20) {
                                
                                VStack {
                                    Text(page.label)
                                        .font(.system(size: 28, weight: .semibold))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineSpacing(7)
                                        .scaleEffect(x: 1.4, y: 1.15)
                                }
                                .offset(y: -110)
                                
                                
                                VStack {
                                    Text(page.text)
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .offset(y: -100)
                                
                                
                                VStack {
                                    NavigationLink(destination: HomeScreenn()) {  
                                        Image("frame")
                                            .resizable()
                                            .frame(width: 327, height: 56)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.top, 10)
                                    .offset(y: -100)
                                }
                            }
                            .padding(.vertical, 5)
                            .frame(width: 327, height: 194)
                            .background(Color.black)
                            
                            
                            VStack {
                                Image(page.bottomImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150)
                                    .padding(.top, 10)
                                    .background(Color.gray) 
                                                                       .onAppear {
                                                                           print("Loading bottom image: \(page.bottomImage)")
                                                                       }
                            }
                            .offset(y: -15)
                            .frame(maxHeight: .infinity, alignment: .top)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .ignoresSafeArea(.all, edges: .top)
            }
        }
        .preferredColorScheme(.dark)
    }
}


#Preview {
    Welcome()
}
