//
//  ImageManager.swift
//  Sippy
//
//  Created by Syed Kashan on 10/16/19.
//  Copyright (c) 2019 Syed Kashan. All rights reserved.

import Foundation
import Swinject
import Kingfisher

protocol IImageManager: class {
	// do someting...
    func setImage(url: String, imageView: UIImageView)
}

class ImageManager: IImageManager {
	 static let shared = ImageManager()
    
    func setImage(url: String, imageView: UIImageView) {
           if let url = URL(string: url) {
               imageView.kf.indicatorType = .activity
               imageView.kf.setImage(with: url)
           }
    }
//    func setImage(lat: Double, long: Double, imageView: UIImageView) {
//        let urlString = "https://maps.googleapis.com/maps/api/staticmap?center=\(lat),\(long)&zoom=15&size=370x100&markers=color:blue%7Clabel:S%7C11211%7C11206%7C11222&key=AIzaSyBGqz7njZq3LcwRlB5O8EDDDSPJqUNhrJo"
//
//           if let url = URL(string: urlString) {
//               imageView.kf.indicatorType = .activity
//               imageView.kf.setImage(with: url)
//           }
//    }
    func downloadImage(`with` urlString: String, completionHandler: @escaping (Bool) -> Void) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                printHydd("Image: \(value.image). Got from: \(value.cacheType)")
                completionHandler(true)
            case .failure(let error):
                printHydd("Error: \(error)")
                completionHandler(false)
            }
        }
    }
}
