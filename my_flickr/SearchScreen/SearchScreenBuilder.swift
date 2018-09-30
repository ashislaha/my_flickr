//
//  SearchScreenBuilder.swift
//  my_flickr
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import Foundation
import UIKit

struct SearchScreenBuilder: SearchScreenBuilderProtocol {
    func buildSearchScreenModule() -> SearchScreenViewController? {
        guard let searchScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchScreenViewController") as? SearchScreenViewController else { return nil }
        // configure the VIPER module
        // View has strong reference of Presenter
        // Presenter has strong reference of Interactor, weak reference of View.
        // Interactor has strong reference of Router, weak reference of Presenter
        // Router has weak reference of View. Builder just builds the initial VIPER module.
        let presenter = SearchScreenPresenter(view: searchScreenVC)
        let router = SearchScreenRouter(viewController: searchScreenVC)
        let interactor = SearchScreenInteractor(router: router, presenter: presenter)
        searchScreenVC.presenter = presenter
        presenter.interactor = interactor
        return searchScreenVC
    }
}

