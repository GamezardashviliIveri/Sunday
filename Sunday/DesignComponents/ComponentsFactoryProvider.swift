import SwiftUI

final class ComponentsFactoryProvider {
    init() {}
    
    var text: some TextFactoryProtocol {
        TextFactory()
    }
    
    var image: some ImageViewFactoryProtocol {
        ImageViewFactory()
    }
    
    
    var button: some ButtonViewFactoryProtocol {
        ButtonViewFactory(componentsFactoryProvider: self)
    }
}
