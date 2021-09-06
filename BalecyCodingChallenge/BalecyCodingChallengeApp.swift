//
//  BalecyCodingChallengeApp.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import SwiftUI

@main
struct BalecyCodingChallengeApp: App {
    let serviceContainer: ServiceContainer
    let mainViewModel: PinBoardViewModel
    
    init() {
        serviceContainer = .init()
        mainViewModel = .init(serviceContainer: serviceContainer)
    }
    
    var body: some Scene {
        WindowGroup {
            PinBoardView(viewModel: AnyViewModel(mainViewModel))
        }
    }
}
