//
//  ImagePickerManager.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 23/03/2020.
//  Copyright (c) 2020 Syed Kashan. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Swinject
import YPImagePicker

enum ImagePickerType: Int {
    case camera = 0
    case gallery
}

protocol IImagePickerManager: class {
    // do someting...

    func openImagePicker(delegate: ImagePickerDelegate)
}

protocol ImagePickerDelegate: class {
    // do someting...
    func didSelectImage(image: UIImage)
    func didCancel()
}

class ImagePickerManager: IImagePickerManager {

    // do someting...
    static let shared = ImagePickerManager()
    weak var delegate: ImagePickerDelegate?

    private init() { }

    deinit {
        print("deinit singleton")
    }

    func openImagePicker(delegate: ImagePickerDelegate) {

        self.delegate = delegate

        var config = YPImagePickerConfiguration()

        config.showsPhotoFilters = false
        config.library.onlySquare = true

        config.library.maxNumberOfItems = 1
        config.library.mediaType = .photo
        config.library.defaultMultipleSelection = false
        config.onlySquareImagesFromCamera = true

        let picker = YPImagePicker(configuration: config)

        picker.didFinishPicking { [unowned picker] items, cancelled in

            if let photo = items.singlePhoto {
//                print(photo.fromCamera) // Image source (camera or library)
//                print(photo.image) // Final image selected by the user
//                print(photo.originalImage) // original image selected by the user, unfiltered
//                print(photo.modifiedImage) // Transformed image, can be nil
//                print(photo.exifMeta) // Print exif meta data of original image.

                self.delegate?.didSelectImage(image: photo.image)
            }

            if cancelled {
                print("Picker was canceled")
            }

            picker.dismiss(animated: true, completion: nil)
        }

        if #available(iOS 13.0, *) {
            picker.modalPresentationStyle = .fullScreen
        }

        UIViewController.top().present(picker, animated: true, completion: nil)
    }

    func didSelectImage(image: UIImage) {
        ///
    }

}
