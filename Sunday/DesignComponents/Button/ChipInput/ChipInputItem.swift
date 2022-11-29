import Foundation

struct ChipInputItem {
    let id: String
    let text: String
    let selected: Bool
    let tapAction: () -> Void

    init(
        id: String,
        text: String,
        selected: Bool,
        tapAction: @escaping () -> Void
    ) {
        self.id = id
        self.text = text
        self.selected = selected
        self.tapAction = tapAction
    }

    func updatedWithSelected(_ selected: Bool) -> Self {
        ChipInputItem(
            id: id,
            text: text,
            selected: selected,
            tapAction: tapAction
        )
    }
}

// MARK: - Identifiable, Equatable, Hashable

extension ChipInputItem: Identifiable, Equatable, Hashable {
    static func == (lhs: ChipInputItem, rhs: ChipInputItem) -> Bool {
        lhs.id == rhs.id &&
        lhs.text == rhs.text &&
        lhs.selected == rhs.selected
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(text)
        hasher.combine(selected)
    }
}
