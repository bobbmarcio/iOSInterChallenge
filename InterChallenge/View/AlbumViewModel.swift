//
//  AlbumViewModel.swift
//  InterChallenge
//
//  Created by Márcio Flores on 25/08/21.
//

import UIKit

struct AlbumViewModel {
    let title: String
    
    init(with model: Album) {
        title = model.title
    }
}
