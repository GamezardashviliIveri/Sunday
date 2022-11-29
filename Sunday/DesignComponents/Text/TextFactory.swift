import SwiftUI

protocol TextFactoryProtocol {
    associatedtype TitleText: View
    func makeTitleText(text: String) -> TitleText
    associatedtype H1Text: View
    func makeH1(text: String) -> H1Text
    associatedtype H4Text: View
    func makeH4(text: String) -> H4Text
}

struct TextFactory: TextFactoryProtocol {
    init() { }
    
    func makeTitleText(text: String) -> some View {
        Text(text)
            .font(.custom("Nordeco-Bold", size: 24))
    }
    func makeH1(text: String) -> some View {
        Text(text)
            .font(.custom("SF-Pro-Rounded-Medium", size: 27))
    }
    func makeH4(text: String) -> some View {
        Text(text)
            .font(.custom("SF-Pro-Display-Medium", size: 16))
    }
}
