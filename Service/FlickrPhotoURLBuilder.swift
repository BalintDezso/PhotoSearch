//
//  FlickrPhotoURLBuilder.swift
//  Service
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation

class FlickrPhotoURLBuilder {
    
    private let apiKey: String
    private let baseServiceURL: URL = URL(string: "https://api.flickr.com/services/rest/")!
    
    init(withAPIKey apiKey: String) {
        self.apiKey = apiKey
    }
    
    func searchURL(withKeyword keyword: String,
                   startingPage: Int,
                   itemsPerPage: Int) throws -> URL {
        
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "method", value: "flickr.photos.search"))
        queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        queryItems.append(URLQueryItem(name: "format", value: "json"))
        queryItems.append(URLQueryItem(name: "nojsoncallback", value: "1"))
        queryItems.append(URLQueryItem(name: "text", value: keyword))
        queryItems.append(URLQueryItem(name: "page", value: "\(startingPage)"))
        queryItems.append(URLQueryItem(name: "per_page", value: "\(itemsPerPage)"))
        
        var urlComponents = URLComponents(url: baseServiceURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let finalURL = urlComponents?.url else {
            throw ServiceError.invalidURL(details: "Base URL: \(baseServiceURL.absoluteString), queryItems: \(queryItems)")
        }
        
        return finalURL
    }
    
}
