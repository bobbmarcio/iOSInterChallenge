//
//  PhotoViewModel.swift
//  InterChallenge
//
//  Created by Márcio Flores on 25/08/21.
//

import UIKit
import Alamofire

struct PhotoViewModel {
    public var photos = [Photo]()
    
    public func fillPhotos(from albumId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)").validate().responseJSON { response in
            guard response.error == nil else {
                return
            }
            
            let event: PhotoFetchEvent
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([Photo].self, from: data)
                    event = PhotoFetchEvent(identifier: UUID().uuidString, result: .success(models))
                    Bus.shared.publishPhoto(type: .photoFetch, event: event)
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
}

class PhotoModel {
    let title: String
    
    init(with model: Photo) {
        title = model.title
    }
}
