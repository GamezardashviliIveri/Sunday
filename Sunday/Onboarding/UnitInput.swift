import Foundation

struct UnitInput {
    let id: String
    let name: String

    init(
        id: String,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}

// MARK: - Equatable

extension UnitInput: Equatable {
    static func == (lhs: UnitInput, rhs: UnitInput) -> Bool {
        lhs.id == rhs.id
    }
}
