//
//  ChallengeViewModel.swift
//  InterChallenge
//
//  Created by Márcio Flores on 24/08/21.
//

import UIKit
import Alamofire

class ChallengeViewModel {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    
    init(with model: User) {
        id = model.id
        name = model.name
        username = model.username
        email = model.email
        phone = model.phone
    }
}
