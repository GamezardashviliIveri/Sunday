import SwiftUI

@main
struct SundayApp: App {
    var body: some Scene {
        WindowGroup {
            FactoryOfFactories().getInitialView()
        }
    }
}
