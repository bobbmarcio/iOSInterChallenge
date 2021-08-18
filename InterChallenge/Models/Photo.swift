import Foundation

struct Photo: Codable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, albumId, title, url, thumbnailUrl
    }
    
    class PhotoBuilder {
        
        func build(photo: Photo) -> Photo {
            
            return Photo(id: photo.id, albumId: photo.albumId, title: photo.title, url: photo.url, thumbnailUrl: photo.thumbnailUrl)
        }
    }
}
