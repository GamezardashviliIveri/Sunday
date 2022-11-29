import SwiftUI

struct OnboardingView<
    ViewModel: OnboardingViewModelProtocol,
    Router: OnboardingRouterProtocol
>: View {
    @StateObject var viewModel: ViewModel
    @StateObject var router: Router
    @State var chipInputItems: [ChipInputItem] = []
    let componentsFactoryProvider: ComponentsFactoryProvider
    
    var body: some View {
        VStack(spacing: 33) {
            VStack(spacing: 120) {
                VStack(spacing: 26) {
                    componentsFactoryProvider.text.makeTitleText(text: "sunday")
                        .multilineTextAlignment(.center)
                        .padding(.top, 16)
                        .foregroundColor(.white)
                    componentsFactoryProvider.image.makeImageView(config: .init(image: Image("seperator"), contentMode: .fit))
                }
                VStack(spacing: 18) {
                    componentsFactoryProvider.text.makeH1(text: "How can we help?")
                    componentsFactoryProvider.text.makeH4(text: "Choose an area you want to focus on improving.")
                }
            }
            VStack(spacing: 18) {
                componentsFactoryProvider.button.makeSelectTextButtonView(items: $chipInputItems)
            }
            Spacer()
        }
        .onReceive(viewModel.loadUnitInputsPublisher) { _ in
            setupInputItems()
        }
        .onAppear {
            setupInputItems()
            viewModel.onAppear()
        }
        .overlay {
            VStack {
                Spacer(minLength: 0)
                componentsFactoryProvider.button.makeTextButtonView(textButtonConfig: .init(title: "Continue", isDisabled: viewModel.shouldDisableButton))
                    .padding(16)
            }
        }
        .background(
            componentsFactoryProvider.image.makeImageView(config: .init(image: Image("onboarding-background"), contentMode: .fill))
                .ignoresSafeArea()
        )
        .preferredColorScheme(.dark)
    }
    
    private func setupInputItems() {
        chipInputItems = viewModel.unitInputs.map { input in
            ChipInputItem(
                id: input.id,
                text: input.name,
                selected: input.id == viewModel.selectedUnit?.id
            ) {
                viewModel.didSelectUnit(id: input.id)
            }
        }
    }
}
