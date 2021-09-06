//
//  DatabaseService.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import Foundation
import Combine
import FirebaseFirestore

class DatabaseService {
    struct Post {
        let id: String
        let author: String
        let message: String
        let postDate: Date
    }
    
    @Published var posts: [Post] = []
    
    var subscriptions: Set<AnyCancellable> = []
    
    init() {
        // subscribe to posts in Firestore
        Firestore.firestore()
            .collection("posts")
            .order(by: "postDate")
            .publisher()
            .catch { error -> Just<[QueryDocumentSnapshot]> in
                print("error getting posts: \(error)")
                return Just([])
            }
            .map { $0.compactMap { Post(fromFirebaseDictionary: $0.data(), withID: $0.documentID) } }
            .assignNoRetain(to: \.posts, on: self)
            .store(in: &subscriptions)
    }
    
    func addPost(author: String, message: String) {
        Firestore.firestore()
            .collection("posts")
            .addDocument(data: ["author": author, "message": message, "postDate": FieldValue.serverTimestamp()])
    }
}

extension DatabaseService.Post {
    init?(fromFirebaseDictionary firebaseDictionary: [String: Any], withID id: String) {
        guard let author = firebaseDictionary["author"] as? String,
              let message = firebaseDictionary["message"] as? String,
              let postDate = (firebaseDictionary["postDate"] as? Timestamp)?.dateValue() else { return nil }
        
        self.init(id: id, author: author, message: message, postDate: postDate)
    }
}
