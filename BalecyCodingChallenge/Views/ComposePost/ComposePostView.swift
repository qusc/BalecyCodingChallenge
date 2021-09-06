//
//  ComposePostView.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import SwiftUI

struct ComposePostView: View {
    struct ViewState {
        
    }
    
    enum Input {
        // TODO
    }
    
    @ObservedObject var viewModel: AnyViewModel<ViewState, Input>
    
    var body: some View {
        ZStack {
            Color.clear
            
            Text("TODO")
        }
    }
}
