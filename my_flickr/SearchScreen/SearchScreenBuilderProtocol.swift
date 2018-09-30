//
//  SearchScreenBuilderProtocol.swift
//  my_flickr
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import Foundation
import UIKit

protocol SearchScreenBuilderProtocol {
    func buildSearchScreenModule() -> SearchScreenViewController?
}

protocol SearchScreenViewProtocol: class {
    func reloadPhotoView(_ photos: [Photo])
}

protocol SearchScreenPresenterProtocol: class {
    func fetchPhotos(params: [String: String], searchType: SearchType)
    func reloadPhotoView(_ photos: [Photo])
    func intitialisePhotoDetailsPage(_ photo: Photo, image: UIImage)
}

protocol SearchScreenInteractorProtocol: class {
    func fetchPhotos(params: [String: String], searchType: SearchType)
    func intitialisePhotoDetailsPage(_ photo: Photo, image: UIImage)
}

protocol SearchScreenRouterProtocol: class {
    func intitialisePhotoDetailsPage(_ photo: Photo, image: UIImage)
}
