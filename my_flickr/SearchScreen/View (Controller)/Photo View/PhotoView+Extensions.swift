//
//  PhotoView+Extensions.swift
//  my_flickr
//
//  Created by Ashis Laha on 9/30/18.
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

// MARK: UICollectionViewDataSource
extension PhotoView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoView.PhotoCollectionCellIdentifier, for: indexPath) as? PhotoCollectionCell else { return UICollectionViewCell() }
        cell.photo = photos[indexPath.row]
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension PhotoView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // initialise the details of photo if needed
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension PhotoView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3 - 6, height: frame.width/3 - 6)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

// MARK: UIScrollViewDelegate
extension PhotoView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= PhotoView.photoBottomThreshold {
            fetchNextPhotoSet()
        } else {
           loadMore = false
        }
    }
    private func fetchNextPhotoSet() {
        if !loadMore {
            print("load More photos")
            loadMore = true
            delegate?.fetchNextPhotoSet()
        }
    }
}

