//
//  ViewController.swift
//  PhotoSearch
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import UIKit
import Service

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Service.photo.search(withKeyword: "cat", startingPage: 1, itemsPerPage: 10) { (photoSearch, error) in
            if let error = error {
                print("Did fail photo search with error: \(error)")
                return
            }
            
            print("Did fetch photos \(photoSearch)")
        }
    }
}

