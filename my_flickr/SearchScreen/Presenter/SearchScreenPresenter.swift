//
//  SearchScreenPresenter.swift
//  my_flickr
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

final class SearchScreenPresenter: SearchScreenPresenterProtocol {
    
    public var interactor: SearchScreenInteractorProtocol? // Strong hold of Interactor
    weak var searchScreenView: SearchScreenViewProtocol? // Weak hold of View
    // init
    init(view: SearchScreenViewProtocol?){
        searchScreenView = view
    }
    
    func fetchPhotos(params: [String: String], searchType: SearchType) {
        interactor?.fetchPhotos(params: params, searchType: searchType)
    }
    func reloadPhotoView(_ photos: [Photo]) {
        searchScreenView?.reloadPhotoView(photos)
    }
    func intitialisePhotoDetailsPage(_ photo: Photo, image: UIImage) {
        interactor?.intitialisePhotoDetailsPage(photo, image: image)
    }
}
