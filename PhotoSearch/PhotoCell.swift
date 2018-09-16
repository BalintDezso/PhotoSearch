//
//  PhotoCell.swift
//  PhotoSearch
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var photoImage: UIImage? {
        return photoImageView.image
    }
    
    func setup(withIcon icon: URL?, title: String) {
        
        photoImageView.contentMode = .scaleAspectFit
        
        photoImageView.sd_setImage(with: icon,
                                   placeholderImage: #imageLiteral(resourceName: "placeHolder"),
                                   options: .highPriority,
                                   progress: nil) { [weak self] (_, error, _, _) in
            
            if error == nil {
                self?.photoImageView.contentMode = .scaleAspectFill
            }
        }
        titleLabel.text = title
    }
}
