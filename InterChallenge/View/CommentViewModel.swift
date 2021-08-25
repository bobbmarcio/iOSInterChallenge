//
//  CommentViewModel.swift
//  InterChallenge
//
//  Created by Márcio Flores on 25/08/21.
//

import UIKit
import Alamofire

struct CommentViewModel {
    public var comments = [Comment]()
    
    public func fillComments(from postId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/comments?postId=\(postId)").validate().responseJSON { response in
            guard response.error == nil else {
                return
            }
            
            let event: CommentFetchEvent
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([Comment].self, from: data)
                    event = CommentFetchEvent(identifier: UUID().uuidString, result: .success(models))
                    Bus.shared.publishComment(type: .commentFetch, event: event)
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
   }
}

class CommentModel {
    let title: String
    let body: String
    
    init(with model: Comment) {
        title = model.name
        body = model.body
    }
}
