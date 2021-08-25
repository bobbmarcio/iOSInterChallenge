//
//  AlbumViewModel.swift
//  InterChallenge
//
//  Created by Márcio Flores on 25/08/21.
//

import UIKit
import Alamofire

struct AlbumViewModel {
    public var albums = [Album]()
    
    public func fillAlbums(from userId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/albums?userId=\(userId)").validate().responseJSON { response in
            guard response.error == nil else {
                return
            }
            
            let event: AlbumFetchEvent
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([Album].self, from: data)
                    event = AlbumFetchEvent(identifier: UUID().uuidString, result: .success(models))
                    Bus.shared.publishAlbum(type: .albumFetch, event: event)
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
}

class AlbumModel {
    let title: String
    
    init(with model: Album) {
        title = model.title
    }
}
