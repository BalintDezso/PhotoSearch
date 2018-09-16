//
//  Service.swift
//  Service
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation
import Networking

public final class Service {

    public fileprivate(set) static var photo: PhotoService! = nil
}

public final class ServiceFactory {
    
    public static func createServices() {
        
        let network = NetworkFactory.makeNetwork()
        let photoURLBuilder = FlickrPhotoURLBuilder(withAPIKey: "ea24974488c79a2033686a9960265d2b")
        
        Service.photo = FlickrPhotoService(withNetwork: network,
                                           urlBuilder: photoURLBuilder)
    }
}

