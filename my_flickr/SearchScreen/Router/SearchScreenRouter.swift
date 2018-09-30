//
//  SearchScreenRouter.swift
//  my_flickr
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

final class SearchScreenRouter: SearchScreenRouterProtocol {
    
    weak var viewController: SearchScreenViewController? // weak reference
    
    init(viewController: SearchScreenViewController?) {
        self.viewController = viewController
    }
    
    func intitialisePhotoDetailsPage(_ photo: Photo, image: UIImage) {
        // initialise the photo details page here and present it
        // viewController?.present(someDetailsVC, animated: true, completion: nil)
    }
}
