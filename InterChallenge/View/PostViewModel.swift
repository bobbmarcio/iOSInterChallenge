//
//  PostViewModel.swift
//  InterChallenge
//
//  Created by Márcio Flores on 24/08/21.
//

import UIKit

struct PostViewModel {
    let title: String
    let body: String
    
    init(with model: Post) {
        title = model.title
        body = model.body
    }
}
