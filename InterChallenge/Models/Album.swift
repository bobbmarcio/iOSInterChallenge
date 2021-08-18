import Foundation

struct Album: Codable {
    let id: Int
    let userId: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id, userId, title
    }
    
    class AlbumBuilder {
        
        func build(album: Album) -> Album {
            return Album(id: album.id, userId: album.userId, title: album.title)
        }
    }
}
