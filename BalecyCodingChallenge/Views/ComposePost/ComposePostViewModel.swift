//
//  ComposePostViewModel.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import Foundation
import Combine

class ComposePostViewModel: ViewModel {
    @Published var viewState: ComposePostView.ViewState
    
    let serviceContainer: ServiceContainer
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
        viewState = .init()
    }
    
    func trigger(_ input: ComposePostView.Input) {
        switch input {
            // TODO
        }
    }
}
