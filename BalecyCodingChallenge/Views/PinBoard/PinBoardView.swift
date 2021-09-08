//
//  PinBoardView.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import SwiftUI

struct PinBoardView: View {
    struct ViewState {
        var posts: [Post] = []
        var composePostViewModel: AnyViewModel<ComposePostView.ViewState, ComposePostView.Input>?
        
        // TODO
        
        struct Post: Identifiable { let id: String; let author: String; let message: String; let date: Date }
    }
    
    enum Input {
        case showComposePostView(Bool)
    }
    
    @ObservedObject var viewModel: AnyViewModel<ViewState, Input>
    
    let postDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 46) {
                headerView
                postsView
            }
            .padding(36)
        }
        .onTapGesture { viewModel.trigger(.showComposePostView(false)) }
        .overlay(composePostButton.padding(.vertical, 36).padding(.horizontal, 45), alignment: .bottom)
        .overlay(
            viewModel.composePostViewModel.map {
                ComposePostView(viewModel: $0)
                    .background(Color.white.padding(.bottom, -100))
                    .frame(height: 300)
                    .clipped()
                    .shadow(color: .primary.opacity(0.2), radius: 30)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.balecySpring)
            },
            alignment: .bottom
        )
    }
    
    var headerView: some View {
        HStack(spacing: 22) {
            Image("logo-challenge")
                .shadow(color: .primary.opacity(0.27), radius: 11, y: 7)
            
            Text("Balecy Coding Challenge")
                .font(.montserrat(size: 22, weight: .medium))
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
    
    var postsView: some View {
        VStack(spacing: 23) {
            HStack {
                Text("Pin Board")
                    .font(.montserrat(size: 16, weight: .medium))
                
                Spacer()
                
                Text("# Post(s)")
                    .font(.montserrat(size: 16, weight: .regular))
                    .opacity(0.4)
            }
            .foregroundColor(.primary)
            
            ForEach(viewModel.posts) { post in
                postView(for: post)
            }
        }
    }
    
    func postView(for post: ViewState.Post) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(post.author)
                    .font(.montserrat(size: 16, weight: .bold))
                
                Spacer()
                
                Text(postDateFormatter.string(from: post.date))
                    .font(.montserrat(size: 16, weight: .medium))
            }
            
            Text(post.message)
                .font(.montserrat(size: 14, weight: .medium))
        }
        .padding(25)
        .foregroundColor(.white)
        .background(Color.primary)
        .cornerRadius(8)
    }
    
    var composePostButton: some View {
        Button { viewModel.trigger(.showComposePostView(true)) } label: {
            ZStack {
                Color.white
                
                Text("Add Post...")
                    .foregroundColor(.primary)
                    .font(.montserrat(size: 16, weight: .bold))
            }
            .frame(height: 44)
            .cornerRadius(8)
            .shadow(color: .primary.opacity(0.3), radius: 30)
        }
    }
}
