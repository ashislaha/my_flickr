//
//  PhotoView.swift
//  my_flickr
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoViewDelegate: class {
    func fetchNextPhotoSet()
}

class PhotoView: UIView {
    
    // properties
    private var collectionView: UICollectionView!
    public var photos: [Photo] = [] {
        didSet {
            reloadPhotos()
        }
    }
    public weak var delegate: PhotoViewDelegate?
    static let photoBottomThreshold: CGFloat = 300
    static let PhotoCollectionCellIdentifier = "PhotoCollectionCellIdentifier"
    var loadMore: Bool = false
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionViewSetUp()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewSetUp()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // setup collectionView
    private func collectionViewSetUp() {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoView.PhotoCollectionCellIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = true
    }
    
    // relaod collection (if necessary)
    public func reloadPhotos() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // invalidate view layout
    public func invalidateLayout() {
       collectionView.collectionViewLayout.invalidateLayout()
    }
}
