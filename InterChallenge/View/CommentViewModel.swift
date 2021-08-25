//
//  CommentViewModel.swift
//  InterChallenge
//
//  Created by Márcio Flores on 25/08/21.
//

import UIKit

struct CommentViewModel {
    let title: String
    let body: String
    
    init(with model: Comment) {
        title = model.name
        body = model.body
    }
}
