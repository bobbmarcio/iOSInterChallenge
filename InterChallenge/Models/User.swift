import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, username, email, phone
    }
    
    class UserBuilder {
        
        func build(user: User) -> User {
            return User(id: user.id, name: user.name, username: user.username, email: user.email, phone: user.phone)
        }
    }
}
