//
//  NetworkFactory.swift
//  Networking
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation

public class NetworkFactory {
    
    static func makeNetwork() -> Network {
        
        return AlamofireNetwork()
    }
}
