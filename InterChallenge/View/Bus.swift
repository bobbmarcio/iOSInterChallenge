//
//  Bus.swift
//  InterChallenge
//
//  Created by Márcio Flores on 25/08/21.
//

import Foundation

class Bus {
    static let shared = Bus()
    
    private init() {}
    
    enum EventType {
        case userFetch
        case postFetch
    }
    
    struct SubscriptionUser {
        let type: EventType
        let queue: DispatchQueue
        let block: ((Event<[User]>) -> Void)
    }
    
    struct SubscriptionPost {
        let type: EventType
        let queue: DispatchQueue
        let block: ((Event<[Post]>) -> Void)
    }
    
    private var subscriptionsUser = [SubscriptionUser]()
    private var subscriptionsPost = [SubscriptionPost]()
    
    func subscribeOnUser(_ event: EventType, block: @escaping ((Event<[User]>) -> Void)) {
        let new = SubscriptionUser(type: event, queue: .main, block: block)
        subscriptionsUser.append(new)
    }
    
    func subscribeOnPost(_ event: EventType, block: @escaping ((Event<[Post]>) -> Void)) {
        let new = SubscriptionPost(type: event, queue: .main, block: block)
        subscriptionsPost.append(new)
    }
    
    func publishUser(type: EventType, event: UserFetchEvent) {
        let subscribers = subscriptionsUser.filter({ $0.type == type })
        subscribers.forEach { subscriber in
            subscriber.queue.async {
                subscriber.block(event)
            }
        }
    }
    
    func publishPost(type: EventType, event: PostFetchEvent) {
        let subscribers = subscriptionsPost.filter({ $0.type == type })
        subscribers.forEach { subscriber in
            subscriber.queue.async {
                subscriber.block(event)
            }
        }
    }
}
