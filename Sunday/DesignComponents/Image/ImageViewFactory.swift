import SwiftUI

protocol ImageViewFactoryProtocol {
    associatedtype SomeImageView: View
    func makeImageView(config: ImageConfig) -> SomeImageView
}

struct ImageViewFactory: ImageViewFactoryProtocol {
    func makeImageView(config: ImageConfig) -> some View {
        config.image
            .resizable()
            .aspectRatio(contentMode: config.contentMode)
            .frame(width: config.width, height: config.height)
            .clipped()
    }
}
