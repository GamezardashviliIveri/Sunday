import SwiftUI

final class OnboardingModuleFactory {
    let componentsFactoryProvider: ComponentsFactoryProvider

    init(componentsFactoryProvider: ComponentsFactoryProvider) {
        self.componentsFactoryProvider = componentsFactoryProvider
    }
    
    func make() -> some View {
        let router = OnboardingRouter()
        let viewModel = OnboardingViewModel()
        return OnboardingView(viewModel: viewModel, router: router, componentsFactoryProvider: componentsFactoryProvider)
    }
}
