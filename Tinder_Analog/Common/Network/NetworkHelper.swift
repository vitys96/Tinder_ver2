//
//  NetworkHelper.swift
//  Tinder_Analog
//
//  Created by Vitaly on 17.10.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class NetworkHelper {
    
    static func uploadData(data: RegistrationViewModel, completion: @escaping (Error?) -> Void) {
        guard
            let email = data.email,
            let passwd = data.password,
            let image = data.image,
            let name = data.fullName else { return }
        Auth.auth().createUser(withEmail: email, password: passwd) { (_, err) in
            if let err = err {
                completion(err)
                return
            }
            let filename = UUID().uuidString
            let imageData = image.jpegData(compressionQuality: 0.3) ?? Data()
            let ref = Storage.storage().reference(withPath: "/images/\(filename)")
            ref.putData(imageData, metadata: nil) { (_, error) in
                if let err = error {
                    completion(err)
                    return
                }
                ref.downloadURL { (imageUrl, error) in
                    if let err = error {
                        completion(err)
                        return
                    }
                    let imageUrl = imageUrl?.absoluteString ?? ""
                    let uid = Auth.auth().currentUser?.uid ?? ""
                    let docData: [String : Any] = ["uid" : uid,
                                                   "fullName" : name,
                                                   "email" : email,
                                                   "password" : passwd,
                                                   "imageUrl" : [imageUrl]]
                    Firestore.firestore().collection("Users").document(uid).setData(docData) { (error) in
                        if let err = error {
                            completion(err)
                            return
                        }
                        completion(nil)
                    }
                }
            }
        }
    }
    
    static func fetchUserData(completion: @escaping (User?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        Firestore.firestore().collection("Users").document(uid).getDocument { (snapshot, error) in
            if let _ = error {
                completion(nil)
                return
            }
            guard let dictData = snapshot?.data() else {
                completion(nil)
                return }
            completion(User(dictionary: dictData))
        }
    }
    static func fetchUserPhotos(imageUrls: [String], completion: @escaping ([UIImage]?) -> Void) {
        let downloader = SDWebImageManager()
        var arrayOfImages: [UIImage] = []
        let urls = imageUrls.map( {URL(string: $0)} )
        urls.forEach({
            downloader.loadImage(with: $0, options: [.retryFailed, .highPriority], progress: nil) { (image, _, _, _, _, _) in
                guard let image = image else { return }
                arrayOfImages.append(image)
            }
        })
        completion(arrayOfImages)
    }
    
}
