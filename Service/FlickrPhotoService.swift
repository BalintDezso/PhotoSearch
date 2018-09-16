//
//  FlickrPhotoService.swift
//  Service
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation
import Model
import Networking

class FlickrPhotoService: PhotoService {
    
    let network: Network
    let urlBuilder: FlickrPhotoURLBuilder
    
    init(withNetwork network: Network,
         urlBuilder: FlickrPhotoURLBuilder) {
        
        self.network = network
        self.urlBuilder = urlBuilder
    }
    
    func search(withKeyword keyword: String,
                startingPage: Int,
                itemsPerPage: Int,
                completion: @escaping (PhotoSearch?, Error?) -> Void) {
        
        do {
            let searchURL = try urlBuilder.searchURL(withKeyword: keyword,
                                                     startingPage: startingPage,
                                                     itemsPerPage: itemsPerPage)
            
            var urlRequest = URLRequest(url: searchURL)
            urlRequest.httpMethod = "GET"
            
            network.send(request: urlRequest) { (data, error) in
                
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, ServiceError.missingDataWhereExpected(details: "No data from request: \(urlRequest)"))
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let photoSearchResponse = try jsonDecoder.decode(PhotoSearch.self, from: data)
                    completion(photoSearchResponse, nil)
                } catch {
                    completion(nil, error)
                }
            }
        } catch {
            completion(nil, error)
        }
    }
    
    func url(for photo: Photo,
             size: PhotoSize) -> URL? {
        
        do {
            let url = try urlBuilder.url(for: photo, size: size)
            
            return url
        } catch {
            print("Failed building URL for photo: \(photo) and size: \(size.rawValue) with error: \(error)")
            return nil
        }
    }
}
