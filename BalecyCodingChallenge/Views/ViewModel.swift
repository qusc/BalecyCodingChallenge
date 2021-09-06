//
//  ViewModel.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import Foundation
import Combine

protocol ViewModel: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype ViewState
    associatedtype Input
    
    var viewState: ViewState { get }
    func trigger(_ input: Input)
}

extension AnyViewModel: Identifiable where State: Identifiable {
    var id: State.ID {
        viewState.id
    }
}

@dynamicMemberLookup
final class AnyViewModel<State, Input>: ViewModel {
    private let getObjectWillChange: () -> AnyPublisher<Void, Never>
    private let getState: () -> State
    private let getTrigger: (Input) -> Void
    
    var objectWillChange: AnyPublisher<Void, Never> {
        getObjectWillChange()
    }
    
    var viewState: State {
        getState()
    }
    
    func trigger(_ input: Input) {
        getTrigger(input)
    }
    
    subscript<Value>(dynamicMember keyPath: KeyPath<State, Value>) -> Value {
        viewState[keyPath: keyPath]
    }
    
    init<V: ViewModel>(_ viewModel: V) where V.ViewState == State, V.Input == Input {
        self.getObjectWillChange = { viewModel.objectWillChange.eraseToAnyPublisher() }
        self.getState = { viewModel.viewState }
        self.getTrigger = viewModel.trigger
    }
}
