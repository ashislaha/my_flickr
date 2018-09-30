//
//  ImageCachingSystem+testcases.swift
//  my_flickrTests
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import XCTest
@testable import my_flickr

extension my_flickrTests {
    
    func testBeginContentAccess() {
        let discardableImageCacheItem = DiscardableImageCacheItem(image: UIImage()) // accessCount = 0
        let beginContentAccess = discardableImageCacheItem.beginContentAccess()
        XCTAssertEqual(beginContentAccess, true)
    }
    
    func testEndContentAccess() {
        let discardableImageCacheItem = DiscardableImageCacheItem(image: UIImage()) // accessCount = 0
        discardableImageCacheItem.endContentAccess() // accessCount = 0 as there is no begin content access
        XCTAssertEqual(discardableImageCacheItem.accessCount, 0)
        
        let _ = discardableImageCacheItem.beginContentAccess() // accessCount = 1
        let _ = discardableImageCacheItem.beginContentAccess() // accessCount = 2
        discardableImageCacheItem.endContentAccess() // accessCount = 1
        XCTAssertEqual(discardableImageCacheItem.accessCount, 1)
    }
    
    func testDiscardContentIfPossible() {
        var discardableImageCacheItem = DiscardableImageCacheItem(image: UIImage()) // accessCount = 0
        discardableImageCacheItem.discardContentIfPossible() // now image = nil
        XCTAssertNil(discardableImageCacheItem.image)
        
        let beginContentAccess = discardableImageCacheItem.beginContentAccess() //  false because image = nil
        XCTAssertEqual(beginContentAccess, false)
        
        discardableImageCacheItem = DiscardableImageCacheItem(image: UIImage()) // accessCount = 0
        let _ = discardableImageCacheItem.beginContentAccess() // accessCount = 1
        discardableImageCacheItem.discardContentIfPossible() // no change in accessCount
        XCTAssertNotNil(discardableImageCacheItem.image)
    }
    
    func testIsContentDiscarded() {
        let discardableImageCacheItem = DiscardableImageCacheItem(image: UIImage()) // image != nil and accessCount = 0
        let isContentDiscardable1 = discardableImageCacheItem.isContentDiscarded()
        XCTAssertEqual(isContentDiscardable1, false)
        
        discardableImageCacheItem.discardContentIfPossible() // now image = nil
        let isContentDiscardable2 = discardableImageCacheItem.isContentDiscarded()
        XCTAssertEqual(isContentDiscardable2, true)
    }
}
