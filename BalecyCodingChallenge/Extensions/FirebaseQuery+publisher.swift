//
//  FirebaseQuery+publisher.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import Foundation
import Combine
import FirebaseFirestore

extension Query {
    struct Publisher: Combine.Publisher {
        typealias Output = [QueryDocumentSnapshot]
        typealias Failure = Error
        
        let query: Query
        
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            subscriber.receive(subscription: Subscription<S>(query: query, target: subscriber))
        }
    }
    
    class Subscription<Target: Subscriber>: Combine.Subscription
    where Target.Input == Publisher.Output, Target.Failure == Publisher.Failure {
        let listenerRegistration: ListenerRegistration
        
        func request(_ demand: Subscribers.Demand) { }
        
        func cancel() {
            listenerRegistration.remove()
        }
        
        init(query: Query, target: Target) {
            listenerRegistration = query.addSnapshotListener { (snapshot, error) in
                if let snapshot = snapshot {
                    _ = target.receive(snapshot.documents)
                }
                
                if let error = error {
                    target.receive(completion: .failure(error))
                }
            }
        }
    }
    
    func publisher() -> Publisher {
        Publisher(query: self)
    }
}
