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
    }
    
    struct Subscription {
        let type: EventType
        let queue: DispatchQueue
        let block: ((Event<[User]>) -> Void)
    }
    
    private var subscriptions = [Subscription]()
    
    func subscribe(_ event: EventType, block: @escaping ((Event<[User]>) -> Void)) {
        let new = Subscription(type: event, queue: .global(), block: block)
        subscriptions.append(new)
    }
    
    func subscribeOnMain(_ event: EventType, block: @escaping ((Event<[User]>) -> Void)) {
        let new = Subscription(type: event, queue: .main, block: block)
        subscriptions.append(new)
    }
    
    
    
    func publish(type: EventType, event: UserFetchEvent) {
        let subscribers = subscriptions.filter({ $0.type == type })
        subscribers.forEach { subscriber in
            subscriber.queue.async {
                subscriber.block(event)
            }
        }
    }
}
