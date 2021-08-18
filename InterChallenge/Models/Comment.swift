import Foundation

struct Comment: Codable {
    let id: Int
    let postId: Int
    let name: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case id, postId, name, body
    }
    
    class CommentBuilder{
        
        func build(comment: Comment) -> Comment {
            return Comment(id: comment.id, postId: comment.postId, name: comment.name, body: comment.body)
        }
    }
}
