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
    
    func fill() -> [User] {
        var users: [User] = []
        
        AF.request("https://jsonplaceholder.typicode.com/users").validate().responseJSON { response in
            guard response.error == nil else {
                return
            }
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([User].self, from: data)
                    users = models
                }
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
        }
        
        return users
    }
}
