//
//  Photo.swift
//  Model
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation

public struct Photo: Decodable {
    
    public let id: String
    public let owner: String
    public let secret: String
    public let server: String
    public let farm: Int
    public let title: String
    public let isPublic: Bool
    public let isFriend: Bool
    public let isFamily: Bool
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case owner
        case secret
        case server
        case farm
        case title
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        owner = try container.decode(String.self, forKey: .owner)
        secret = try container.decode(String.self, forKey: .secret)
        server = try container.decode(String.self, forKey: .server)
        farm = try container.decode(Int.self, forKey: .farm)
        title = try container.decode(String.self, forKey: .title)
        
        let isPublicInt = try container.decode(Int.self, forKey: .isPublic)
        let isFriendInt = try container.decode(Int.self, forKey: .isFriend)
        let isFamilyInt = try container.decode(Int.self, forKey: .isFamily)

        isPublic = Bool(truncating: isPublicInt as NSNumber)
        isFriend = Bool(truncating: isFriendInt as NSNumber)
        isFamily = Bool(truncating: isFamilyInt as NSNumber)
    }
}
