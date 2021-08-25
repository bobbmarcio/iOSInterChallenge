//
//  PhotoViewModel.swift
//  InterChallenge
//
//  Created by Márcio Flores on 25/08/21.
//

import UIKit
import Alamofire

struct PhotoViewModel {
    let title: String
    
    init(with model: Photo) {
        title = model.title
    }
}
