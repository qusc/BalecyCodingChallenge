//
//  FirebaseDocumentReference+publisher.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import Foundation
import Combine
import FirebaseFirestore

extension DocumentReference {
    struct Publisher: Combine.Publisher {
        typealias Output = [String: Any]
        typealias Failure = Error
        
        let documentReference: DocumentReference
        
        func receive<S>(subscriber: S)
        where S : Subscriber, Failure == S.Failure, Output == S.Input {
            subscriber.receive(
                subscription: Subscription<S>(
                    documentReference: documentReference,
                    target: subscriber
                )
            )
        }
    }
    
    class Subscription<Target: Subscriber>: Combine.Subscription
    where Target.Input == Publisher.Output, Target.Failure == Publisher.Failure {
        let listenerRegistration: ListenerRegistration
        
        func request(_ demand: Subscribers.Demand) { }
        
        func cancel() {
            listenerRegistration.remove()
        }
        
        init(documentReference: DocumentReference, target: Target) {
            listenerRegistration = documentReference.addSnapshotListener { (snapshot, error) in
                if let snapshot = snapshot, let data = snapshot.data() {
                    _ = target.receive(data)
                }
                
                if let error = error {
                    target.receive(completion: .failure(error))
                }
            }
        }
    }
    
    func publisher() -> Publisher {
        Publisher(documentReference: self)
    }
}
