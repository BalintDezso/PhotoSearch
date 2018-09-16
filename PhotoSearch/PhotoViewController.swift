//
//  PhotoViewController.swift
//  PhotoSearch
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import UIKit
import Model
import Service
import SDWebImage
import Hero

class PhotoViewController: UIViewController {
    
    var photoImage: UIImage!
    var photoId: String!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photoImage
        photoImageView.hero.id = photoId
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
