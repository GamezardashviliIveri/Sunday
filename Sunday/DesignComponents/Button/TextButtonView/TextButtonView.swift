import SwiftUI

struct TextButtonView: View {
    let textButtonConfig: TextButtonConfig
    let componentsFactoryProvider: ComponentsFactoryProvider
    
    var body: some View {
        HStack {
            Spacer()
            componentsFactoryProvider.text.makeH4(text: textButtonConfig.title)
                .foregroundColor(Color.white)
                .padding(.horizontal, 16)
            Spacer()
        }
        .frame(height: 56)
        .background(Color.primary)
        .cornerRadius(20)
        .opacity(textButtonConfig.isDisabled ? 0.7 : 1)
    }
}
