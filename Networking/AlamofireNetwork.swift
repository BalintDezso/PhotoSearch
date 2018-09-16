//
//  AlamofireNetwork.swift
//  Networking
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetwork: Network {
    
    private let session: SessionManager
    
    required init() {
        
        let configuration = URLSessionConfiguration.default
        session = SessionManager(configuration: configuration)
    }
    
    func send(request: URLRequest, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        
        session.request(request).validate().response { response in
            
            if let error = response.error {
                completion(nil, error)
                return
            } else {
                completion(response.data, nil)
            }
        }
    }
}
