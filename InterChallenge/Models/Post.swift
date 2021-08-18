import Foundation

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case id, userId, title, body
    }
    
    class PostBuilder{
    
        func build(post: Post) -> Post {
            return Post(id: post.id, userId: post.userId, title: post.title, body: post.body)
        }
    }
}
