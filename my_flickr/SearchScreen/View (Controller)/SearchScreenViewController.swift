//
//  ViewController.swift
//  my_flickr
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

class SearchScreenViewController: UIViewController {

    var presenter: SearchScreenPresenterProtocol? // strong hold of presenter
    let searchController = UISearchController(searchResultsController: nil)
    private let photoView: PhotoView = {
        let view = PhotoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.style = .whiteLarge
        spinner.color = .purple
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        layoutSetup()
        photoView.delegate = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        photoView.invalidateLayout()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Flickr"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    private func layoutSetup() {
        view.addSubview(photoView)
        view.addSubview(activityIndicator)
        photoView.anchors(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 4, bottom: 0, right: 4))
        activityIndicator.anchors(centerX: view.safeAreaLayoutGuide.centerXAnchor, centerY: view.safeAreaLayoutGuide.centerYAnchor)
    }
}

// MARK: SearchScreenViewProtocol
extension SearchScreenViewController: SearchScreenViewProtocol {
    func reloadPhotoView(_ photos: [Photo]) {
        photoView.photos = photos
        activityIndicator.stopAnimating()
    }
}

// MARK: UISearchResultsUpdating
extension SearchScreenViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // interacting with every single character entered in search bar, used mostly for filtering the result
    }
}

//MARK:- UISearchBarDelegate
extension SearchScreenViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        presenter?.fetchPhotos(params: ["text": constructText(searchText)], searchType: .differentSearchText)
        photoView.photos = []
        activityIndicator.startAnimating()
    }
    
    private func constructText(_ searchText: String) -> String { // if search text contains multiple text
        let texts = searchText.components(separatedBy: " ")
        guard texts.count > 1 else { return searchText }
        var result = ""
        texts.forEach {
            result += $0 + "%20"
        }
        return result
    }
}

// MARK: PhotoViewDelegate
extension SearchScreenViewController: PhotoViewDelegate {
    func fetchNextPhotoSet() {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
        presenter?.fetchPhotos(params: ["text": constructText(searchText)], searchType: .sameSearchTextWithPagination)
        activityIndicator.startAnimating()
    }
}

