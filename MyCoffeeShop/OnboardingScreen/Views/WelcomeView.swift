// WelcomeView.swift
import SwiftUI

struct Welcome: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
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
                                Button(action: {
                                    viewModel.completeOnboarding()
                                }) {
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

                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}
