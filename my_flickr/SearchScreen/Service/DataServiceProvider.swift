//
//  DataServiceProvider.swift
//  my_flickr
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import Foundation

enum DataSourceError: Error {
    case InvalidURL
    case PhotoGenererationError
    case ErrorInServerData
}

final class DataServiceProvider {
    
    private let flickrEndPoint = "https://api.flickr.com/services/rest/"
    private let defaultParams: [String: String] = [
        "method": "flickr.photos.search",
        "api_key": "3e7cc266ae2b0e0d78e279ce8e361736",
        "format": "json",
        "safe_search": "1",
        "nojsoncallback": "1"
    ]
    
    // get photos (using JSONDecoder)
    func getPhotos(params: [String: String], completionHandler: @escaping (([Photo])->())) throws {
        let endPointUrl = getUrl(params)
        guard let url = URL(string: endPointUrl) else { throw DataSourceError.InvalidURL }
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let photosModel = try JSONDecoder().decode(PhotosModel.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(photosModel.photosMetaData.photo)
                }
            } catch let error {
                print(error)
                completionHandler([])
            }
        }
        session.resume()
    }
    
    private func getUrl(_ params: [String: String]) -> String { // input params is text & page like text = kittens, page = 2
        var endPoint = flickrEndPoint + "?"
        defaultParams.forEach {
            endPoint += $0 + "=" + $1 + "&"
        }
        params.forEach {
            endPoint += $0 + "=" + $1 + "&"
        }
        endPoint.removeLast() // remove the last extra "&"
        return endPoint
    }
}

