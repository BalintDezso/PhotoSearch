//
//  Network.swift
//  Networking
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation

protocol Network {
    
    func send(request: URLRequest,
              completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
}
