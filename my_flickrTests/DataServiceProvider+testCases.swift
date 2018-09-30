//
//  DataServiceProvider+testCases.swift
//  my_flickrTests
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import XCTest
@testable import my_flickr

extension my_flickrTests {
    
    func testGetPhotos() {
        
        let dataServiceProvider = DataServiceProvider()
        do {
            try dataServiceProvider.getPhotos(params: ["page": "1", "text": "kitten"]) { (photos) in
            XCTAssertNotNil(photos)
            }
        } catch {
            print(error)
        }
        
        do {
            // text contains space, so this is not a valid url, in application we are appending "%20" for space
            try dataServiceProvider.getPhotos(params: ["page": "1", "text": "this is an invalid url"]) { (photos) in
                XCTAssertNotNil(photos)
            }
        } catch {
            // 0 means InvalidURL
            XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (my_flickr.DataSourceError error 0.)")
        }
    }
}
