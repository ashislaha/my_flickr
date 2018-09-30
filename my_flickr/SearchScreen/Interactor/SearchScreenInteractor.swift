//
//  SearchScreenInteractor.swift
//  my_flickr
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

enum SearchType {
    case differentSearchText // totally new search text
    case sameSearchTextWithPagination // same search text, the user scrolls down to bottom, so fetch next set of data
}

final class SearchScreenInteractor: SearchScreenInteractorProtocol {
    
    var router: SearchScreenRouterProtocol? // strong ref of router
    weak var presenter: SearchScreenPresenterProtocol? // weak ref of presenter
    
    // init
    init(router: SearchScreenRouterProtocol?, presenter: SearchScreenPresenterProtocol?) {
        self.router = router
        self.presenter = presenter
    }
    
    let dataSourceProvider = DataServiceProvider()
    var photoCollections: [Photo] = []
    private var jsonCallBack = 1
    
    func fetchPhotos(params: [String: String], searchType: SearchType) {
        
        // update params
        var paramsDict = params
        if searchType == .differentSearchText {
            paramsDict["page"] = "1"
            jsonCallBack = 1
            photoCollections = []
        } else {
            jsonCallBack += 1
            paramsDict["page"] = "\(jsonCallBack)"
        }
        
        do {
            try dataSourceProvider.getPhotos(params: paramsDict, completionHandler: { [weak self] (photos) in
                guard !photos.isEmpty, let photoCollections = self?.photoCollections else { return }
                
                if photoCollections.isEmpty {
                  self?.photoCollections = photos
                } else {
                    self?.photoCollections.append(contentsOf: photos)
                }
                self?.presenter?.reloadPhotoView(self?.photoCollections ?? [])
            })
        } catch DataSourceError.InvalidURL {
            print("Invalid URL")
        } catch {
            print("Information Insufficient")
        }
    }
    
    func intitialisePhotoDetailsPage(_ photo: Photo, image: UIImage) {
        router?.intitialisePhotoDetailsPage(photo, image: image)
    }
}
