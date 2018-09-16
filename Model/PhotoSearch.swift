//
//  PhotoSearch.swift
//  Model
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation

public struct PhotoSearch: Decodable {
    
    let page: Int
    let pages: Int
    let perPage: Int
    let total: Int
    let photos: [Photo]
    let status : String
    
    private enum TopLevelCodingKeys: String, CodingKey {
        
        case status
        case photos
    }
    
    private enum PhotosCodingKeys:  String, CodingKey {
        
        case page
        case pages
        case perPage = "perpage"
        case total
        case photoss = "photo"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: TopLevelCodingKeys.self)
        
        status = try container.decode(String.self, forKey: .status)
        
        let photosContainer = try container.nestedContainer(keyedBy: PhotosCodingKeys.self,
                                                            forKey: .photos)
        
        page = try photosContainer.decode(Int.self, forKey: .page)
        pages = try photosContainer.decode(Int.self, forKey: .pages)
        perPage = try photosContainer.decode(Int.self, forKey: .perPage)
        total = try photosContainer.decode(Int.self, forKey: .total)
        photos = try photosContainer.decode([Photo].self, forKey: .photoss)
    }
}
