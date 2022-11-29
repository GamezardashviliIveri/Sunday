import SwiftUI

final class InitialViewFactory {
    private var onboardingModuleFactory: OnboardingModuleFactory
    
    init(onboardingModuleFactory: OnboardingModuleFactory) {
        self.onboardingModuleFactory = onboardingModuleFactory
    }
    
    func makeOnboardingView() -> some View {
        onboardingModuleFactory.make()
    }
}
