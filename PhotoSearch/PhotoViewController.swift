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

class PhotoViewController: UIViewController {
    
    var photo: Photo!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = photo.title
        
        let photoURL = Service.photo.url(for: photo, size: .large)
        
        photoImageView.sd_setImage(with: photoURL,
                                   placeholderImage: #imageLiteral(resourceName: "placeHolder"),
                                   options: .highPriority,
                                   completed: nil)
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
