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
        case commentFetch
        case albumFetch
        case photoFetch
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
    
    struct SubscriptionComment {
        let type: EventType
        let queue: DispatchQueue
        let block: ((Event<[Comment]>) -> Void)
    }
    
    struct SubscriptionAlbum {
        let type: EventType
        let queue: DispatchQueue
        let block: ((Event<[Album]>) -> Void)
    }
    
    struct SubscriptionPhoto {
        let type: EventType
        let queue: DispatchQueue
        let block: ((Event<[Photo]>) -> Void)
    }
    
    private var subscriptionsUser = [SubscriptionUser]()
    private var subscriptionsPost = [SubscriptionPost]()
    private var subscriptionsComment = [SubscriptionComment]()
    private var subscriptionsAlbum = [SubscriptionAlbum]()
    private var subscriptionsPhoto = [SubscriptionPhoto]()
    
    func subscribeOnUser(_ event: EventType, block: @escaping ((Event<[User]>) -> Void)) {
        let new = SubscriptionUser(type: event, queue: .main, block: block)
        subscriptionsUser.append(new)
    }
    
    func subscribeOnPost(_ event: EventType, block: @escaping ((Event<[Post]>) -> Void)) {
        let new = SubscriptionPost(type: event, queue: .main, block: block)
        subscriptionsPost.append(new)
    }
    
    func subscribeOnComment(_ event: EventType, block: @escaping ((Event<[Comment]>) -> Void)) {
        let new = SubscriptionComment(type: event, queue: .main, block: block)
        subscriptionsComment.append(new)
    }
    
    func subscribeOnAlbum(_ event: EventType, block: @escaping ((Event<[Album]>) -> Void)) {
        let new = SubscriptionAlbum(type: event, queue: .main, block: block)
        subscriptionsAlbum.append(new)
    }
    
    func subscribeOnPhoto(_ event: EventType, block: @escaping ((Event<[Photo]>) -> Void)) {
        let new = SubscriptionPhoto(type: event, queue: .main, block: block)
        subscriptionsPhoto.append(new)
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
    
    func publishComment(type: EventType, event: CommentFetchEvent) {
        let subscribers = subscriptionsComment.filter({ $0.type == type })
        subscribers.forEach { subscriber in
            subscriber.queue.async {
                subscriber.block(event)
            }
        }
    }
    
    func publishAlbum(type: EventType, event: AlbumFetchEvent) {
        let subscribers = subscriptionsAlbum.filter({ $0.type == type })
        subscribers.forEach { subscriber in
            subscriber.queue.async {
                subscriber.block(event)
            }
        }
    }
    
    func publishPhoto(type: EventType, event: PhotoFetchEvent) {
        let subscribers = subscriptionsPhoto.filter({ $0.type == type })
        subscribers.forEach { subscriber in
            subscriber.queue.async {
                subscriber.block(event)
            }
        }
    }
}
