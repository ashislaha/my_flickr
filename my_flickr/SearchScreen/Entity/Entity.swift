//
//  Entity.swift
//  my_flickr
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import Foundation

// Photos
struct PhotosModel: Decodable {
    let photosMetaData: PhotosMetaData
    
    private enum CodingKeys : String, CodingKey {
        case photosMetaData = "photos"
    }
}

struct PhotosMetaData: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [Photo]
}

// Photo
struct Photo: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let isPublic: Int
    let isFriend: Int
    let isFamily: Int
    
    private enum CodingKeys : String, CodingKey {
        case id, owner, secret, server, farm, title, isPublic = "ispublic", isFriend = "isfriend", isFamily = "isfamily"
    }
}
