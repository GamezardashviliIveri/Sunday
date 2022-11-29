import SwiftUI

protocol ButtonViewFactoryProtocol {
    associatedtype SomeTextButtonView: View
    associatedtype SomeSelectTextButtonView: View

    func makeTextButtonView(textButtonConfig: TextButtonConfig) -> SomeTextButtonView

    func makeSelectTextButtonView(
        items: Binding<[ChipInputItem]>
    ) -> SomeSelectTextButtonView
}
    
struct ButtonViewFactory: ButtonViewFactoryProtocol {
    let componentsFactoryProvider: ComponentsFactoryProvider
    var chipItems = [ChipInputItem]()

    func makeTextButtonView(textButtonConfig: TextButtonConfig) -> some View {
        TextButtonView(textButtonConfig: textButtonConfig, componentsFactoryProvider: componentsFactoryProvider)
    }
    
    func makeSelectTextButtonView(items: Binding<[ChipInputItem]>) -> some View {
        ChipInputView(items: items, componentsFactoryProvider: componentsFactoryProvider)
    }
}
