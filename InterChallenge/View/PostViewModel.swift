//
//  PostViewModel.swift
//  InterChallenge
//
//  Created by Márcio Flores on 24/08/21.
//

import UIKit
import Alamofire

struct PostViewModel {
    public var posts = [Post]()    
    
    public func fillPosts(from userId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/posts?userId=\(userId)").validate().responseJSON { response in
            guard response.error == nil else {
                return
            }
            
            let event: PostFetchEvent
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([Post].self, from: data)
                    event = PostFetchEvent(identifier: UUID().uuidString, result: .success(models))
                    Bus.shared.publishPost(type: .postFetch, event: event)
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
}

class PostModel {
    let title: String
    let body: String
    
    init(with model: Post) {
        title = model.title
        body = model.body
    }
}
