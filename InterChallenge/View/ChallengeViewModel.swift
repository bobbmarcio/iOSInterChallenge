//
//  ViewModel.swift
//  InterChallenge
//
//  Created by Márcio Flores on 25/08/21.
//

import UIKit
import Alamofire

struct ChallengeViewModel {
    public var users: [User] = []

public func fillUsers() {
    AF.request("https://jsonplaceholder.typicode.com/users").validate().responseJSON { response in
        guard response.error == nil else {
            return
        }

        let event: UserFetchEvent
        do {
            if let data = response.data {
                let models = try JSONDecoder().decode([User].self, from: data)
                event = UserFetchEvent(identifier: UUID().uuidString, result: .success(models))
                Bus.shared.publishUser(type: .userFetch, event: event)
            }
        } catch {
            print("Error during JSON serialization: \(error.localizedDescription)")
        }
    }
}
}

class ChallengeModel {
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

