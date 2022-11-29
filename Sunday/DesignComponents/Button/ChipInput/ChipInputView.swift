import SwiftUI

struct ChipInputView: View {
    @Binding var items: [ChipInputItem]
    let componentsFactoryProvider: ComponentsFactoryProvider

    var body: some View {
        VStack(spacing: 18) {
            ForEach(items, id: \.self) { item in
                Button(action: item.tapAction) {
                    if item.selected {
                        HStack {
                            Spacer()
                            componentsFactoryProvider.text.makeH4(text: item.text)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                        .frame(height: 56)
                        .background(Color.primary)
                        .cornerRadius(20)
                        .padding(.horizontal, 35)
                    } else {
                        HStack {
                            Spacer()
                            componentsFactoryProvider.text.makeH4(text: item.text)
                                .foregroundColor(Color.secondary)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                        .frame(height: 56)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.border, lineWidth: 1)
                        )
                        .padding(.horizontal, 35)
                    }
                }
            }
        }
    }
}
