import SwiftUI

struct FactoryOfFactories {
    private var initialViewFactory: InitialViewFactory
    
    init() {
        let componentsFactoryProvider = ComponentsFactoryProvider()
        let onboardingModuleFactory = OnboardingModuleFactory(componentsFactoryProvider: componentsFactoryProvider)
        self.initialViewFactory = InitialViewFactory(onboardingModuleFactory: onboardingModuleFactory)
    }
    
    func getInitialView() -> some View {
        initialViewFactory.makeOnboardingView()
    }
}
