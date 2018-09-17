//
//  PhotoSearch.swift
//  Model
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation

public struct PhotoSearch: Decodable, CustomStringConvertible {
    
    public let page: Int
    public let pages: Int
    public let perPage: Int
    public let total: Int
    public let photos: [Photo]
    public let status : String
  
    public var description: String {
      
      return "Current Page: \(page) of \(pages) with \(photos.count) photos."
    }
  
    private enum SearchResultCodingKeys: String, CodingKey {
        
        case status = "stat"
        case photos
    }
    
    private enum PhotosCodingKeys:  String, CodingKey {
        
        case page
        case pages
        case perPage = "perpage"
        case total
        case photos = "photo"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SearchResultCodingKeys.self)
        
        status = try container.decode(String.self, forKey: .status)
        
        let photosContainer = try container.nestedContainer(keyedBy: PhotosCodingKeys.self,
                                                            forKey: .photos)
        
        page = try photosContainer.decode(Int.self, forKey: .page)
        pages = try photosContainer.decode(Int.self, forKey: .pages)
        perPage = try photosContainer.decode(Int.self, forKey: .perPage)
        photos = try photosContainer.decode([Photo].self, forKey: .photos)
        
        let totalString = try photosContainer.decode(String.self, forKey: .total)
        guard let totalInt = Int(totalString) else {
            throw ModelError.conversionFailure(details: "Failed converting \(totalString) to integer.")
        }
        
        total = totalInt
    }
}
