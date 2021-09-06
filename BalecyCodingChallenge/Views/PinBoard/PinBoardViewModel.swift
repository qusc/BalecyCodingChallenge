//
//  PinBoardViewModel.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import Foundation
import Combine

class PinBoardViewModel: ViewModel {
    @Published var viewState: PinBoardView.ViewState
    
    private let serviceContainer: ServiceContainer
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var showComposePostView: Bool = false
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
        viewState = .init()
        
        serviceContainer.databaseService.$posts
            .map { $0.map { ViewState.Post(id: $0.id, author: $0.author, message: $0.message, date: $0.postDate) } }
            .assignNoRetainWithAnimation(to: \.viewState.posts, on: self)
            .store(in: &subscriptions)
        
        $showComposePostView
            .map { $0 ? AnyViewModel(ComposePostViewModel(serviceContainer: serviceContainer)) : nil }
            .assignNoRetainWithAnimation(to: \.viewState.composePostViewModel, on: self)
            .store(in: &subscriptions)
        
        // TODO
    }
    
    func trigger(_ input: PinBoardView.Input) {
        switch input {
        case .showComposePostView(let showView):
            showComposePostView = showView
        }
    }
}
