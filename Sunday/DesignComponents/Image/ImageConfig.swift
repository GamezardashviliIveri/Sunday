import SwiftUI

struct ImageConfig {
    let image: Image
    let contentMode: ContentMode
    let width: CGFloat?
    let height: CGFloat?

    init(
        image: Image,
        contentMode: ContentMode = .fill,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        self.image = image
        self.contentMode = contentMode
        self.width = width
        self.height = height
    }
}
