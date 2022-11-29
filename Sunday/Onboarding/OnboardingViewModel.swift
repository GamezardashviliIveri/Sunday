import Foundation
import Combine

protocol OnboardingViewModelProtocol: ObservableObject {
    var shouldDisableButton: Bool { get }
    var selectedUnit: UnitInput? { get }
    var unitInputs: [UnitInput] { get }
    var loadUnitInputsPublisher: AnyPublisher<Void, Never> { get }
    func onAppear()
    func didSelectUnit(id: String)
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    @Published private(set) var shouldDisableButton: Bool = true

    private(set) var selectedUnit: UnitInput?
    private(set) var unitInputs: [UnitInput] = []
    
    private let loadUnitInputsSubject = PassthroughSubject<Void, Never>()

    init() {
        unitInputs = [
            UnitInput(id: "1", name: "Reducing stress and anxiety"),
            UnitInput(id: "2", name: "Being more productive"),
            UnitInput(id: "3", name: "Trying new things"),
            UnitInput(id: "4", name: "Staying focused"),
            UnitInput(id: "5", name: "Improving sleep")
        ]
    }
    
    var loadUnitInputsPublisher: AnyPublisher<Void, Never> {
        loadUnitInputsSubject.eraseToAnyPublisher()
    }
}

// MARK: - OnboardingViewModelProtocol

extension OnboardingViewModel {
    func onAppear() {}
    
    func didSelectUnit(id: String) {
        let tappedUnit = unitInputs.first(where: { $0.id == id })
        guard selectedUnit != tappedUnit else {
            selectedUnit = nil
            shouldDisableButton = true
            loadUnitInputsSubject.send()
            return
        }
        selectedUnit = tappedUnit
        shouldDisableButton = false
        loadUnitInputsSubject.send()
    }
}
