//
//  ServiceContainer.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import Foundation
import Firebase

class ServiceContainer {
    let databaseService: DatabaseService
    
    init() {
        FirebaseApp.configure()
        databaseService = .init()
    }
}
