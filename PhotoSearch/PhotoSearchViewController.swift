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
import Hero

class PhotoSearchViewController: UIViewController {
    
    private struct Pagination {
        
        let currentPage: Int
        let totalPages: Int
        let keyword: String
    }

    @IBOutlet private weak var searchIcon: UIImageView!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let itemsPerPage = 20
    private var photos = [Photo]()
    private var isSearching = false {
        didSet {
            searchBar.isUserInteractionEnabled = !isSearching
        }
    }
    
    private var pagination: Pagination?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.placeholder = "Enter a search term"
    }
    
    private func search(withKeyword keyword: String,
                        startingPage: Int,
                        completion: @escaping (PhotoSearch?) -> Void) {
        
        isSearching = true
        
        Service.photo.search(withKeyword: keyword,
                             startingPage: startingPage,
                             itemsPerPage: itemsPerPage) { (photoSearch, error) in
                           
            self.isSearching = false
                                
            if let error = error {
                print("Did fail photo search with error: \(error)")
            }
            
            if let photoSearch = photoSearch {
                print("Did finish fetching photos \(photoSearch)")
            }
                                
            DispatchQueue.main.async {
                completion(photoSearch)
            }
        }
    }
}

extension PhotoSearchViewController {
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        
        if let photoVC = segue.destination as? PhotoViewController,
           let selectedIndex = collectionView.indexPathsForSelectedItems?.first,
           let cell = collectionView.cellForItem(at: selectedIndex) as? PhotoCell {
            
            let heroId = photos[selectedIndex.row].id
            
            photoVC.hero.isEnabled = true
            photoVC.photoImage = cell.photoImage
            photoVC.photoId = heroId
            cell.hero.id = heroId
            
            collectionView.deselectItem(at: selectedIndex, animated: false)
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
        let iconURL = Service.photo.url(for: photo, size: .large)
        
        cell.setup(withIcon: iconURL, title: photo.title)
        
        return cell
    }
}

extension PhotoSearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showPhotoSegue",
                     sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        guard let pagination = pagination,
            pagination.currentPage < pagination.totalPages,
            !isSearching,
            indexPath.row == photos.count - (itemsPerPage / 2) else {
                return
        }
        
        search(withKeyword: pagination.keyword,
               startingPage: pagination.currentPage + 1) { (photosSearch) in
                
                guard let photosSearch = photosSearch else {
                    
                    return
                }
                
                let startIndex = self.photos.count
                let endIndex = self.photos.count + photosSearch.photos.count
                
                self.photos.append(contentsOf: photosSearch.photos)
                
                var indexes = [IndexPath]()
                for i in startIndex..<endIndex {
                    indexes.append(IndexPath(row: i, section: 0))
                }
                
                self.collectionView.insertItems(at: indexes)
                
                self.pagination = Pagination(currentPage: pagination.currentPage + 1,
                                             totalPages: pagination.totalPages,
                                             keyword: pagination.keyword)
        }
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.becomeFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text,
            !searchText.isEmpty else {
                
                let alertController = UIAlertController(title: "",
                                                        message: "Please enter a keyword before searching.",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                return
        }
        
        photos.removeAll()
        collectionView.reloadData()
        pagination = nil
        searchIcon.isHidden = false
        
        search(withKeyword: searchText, startingPage: 1) { (photosSearch) in
            
            guard let photosSearch = photosSearch else {
                
                self.resultLabel.text = "An error occured. Try again."
                return
            }
            
            self.searchIcon.isHidden = true
            self.photos = photosSearch.photos
            self.collectionView.reloadData()
            self.resultLabel.text = "Found \(photosSearch.total) photos."
            self.pagination = Pagination(currentPage: 1,
                                         totalPages: photosSearch.pages,
                                         keyword: searchText)
        }
        
        searchBar.resignFirstResponder()
    }
}
