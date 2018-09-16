//
//  PhotoService.swift
//  Service
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation
import Model

public protocol PhotoService  {
    
    func search(withKeyword keyword: String,
                startingPage: Int,
                itemsPerPage: Int,
                completion: @escaping (PhotoSearch?, Error?) -> Void)
    
    func url(for photo: Photo,
             size: PhotoSize) -> URL?
}
