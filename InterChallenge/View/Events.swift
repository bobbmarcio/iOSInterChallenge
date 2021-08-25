//
//  Events.swift
//  InterChallenge
//
//  Created by Márcio Flores on 25/08/21.
//

import Foundation

class Event<T> {
    let identifier: String
    let result: Result<T, Error>?
    
    init(identifier: String, result: Result<T, Error>?) {
        self.identifier = identifier
        self.result = result
    }
}

class UserFetchEvent: Event<[User]> {
    
}

class PostFetchEvent: Event<[Post]> {
    
}
