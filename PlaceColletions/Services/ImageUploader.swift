//
//  ImageUploader.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/13.
//

import Foundation


import Firebase
import UIKit
import FirebaseStorage


struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        // 이미지 퀄리티를 설정해서 저장
       guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
       
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}

