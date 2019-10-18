//
//  NetworkHelper.swift
//  Tinder_Analog
//
//  Created by Vitaly on 17.10.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit
import Firebase

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
                    let docData = ["uid" : uid,
                                   "fullName" : name,
                                   "email" : email,
                                   "password" : passwd,
                                   "imageUrl" : imageUrl]
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
    
}
