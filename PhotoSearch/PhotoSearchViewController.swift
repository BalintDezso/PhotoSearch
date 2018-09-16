//
//  ViewController.swift
//  PhotoSearch
//
//  Created by Diana Ivascu on 9/16/18.
//  Copyright © 2018 Balint Dezso. All rights reserved.
//

import UIKit
import Service
import Model

class PhotoSearchViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.placeholder = "Enter a search term"
        
        Service.photo.search(withKeyword: "cat", startingPage: 1, itemsPerPage: 10) { (photoSearch, error) in
            if let error = error {
                print("Did fail photo search with error: \(error)")
                return
            }
            
            guard let photoSearch = photoSearch else {
                return
            }
            
            self.photos.append(contentsOf: photoSearch.photos)
            self.collectionView.reloadData()
            self.resultLabel.text = "Found \(photoSearch.total) photos."
            
            print("Did fetch photos \(photoSearch)")
        }
    }
}

extension PhotoSearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = "imageCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        let photo = photos[indexPath.row]
        let iconURL = Service.photo.url(for: photo, size: .medium)
        
        cell.setup(withIcon: iconURL, title: photo.title)
        
        return cell
    }
}

extension PhotoSearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let cellsPerRow = 3
        
        let width = (view.bounds.width - (flowLayout.minimumInteritemSpacing * 2) - flowLayout.sectionInset.left - flowLayout.sectionInset.right) / CGFloat(cellsPerRow)
        
        return CGSize(width: width,
                      height: width * 2)
    }
}

extension PhotoSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
}
