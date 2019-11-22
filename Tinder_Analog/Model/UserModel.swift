//
//  UserModel.swift
//  Tinder_Analog
//
//  Created by Vitaly on 21.10.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

class User {
    
    // defining our properties for our model layer
    var name: String
    var age: String
    var profession: String
    var imageUrl: [String]
    var uid: String
    
    init(dictionary: [String: Any]) {
        // we'll initialize our user here
        self.age = dictionary["age"] as? String ?? "N/A"
        self.profession = dictionary["profession"] as? String ?? ""
        self.name = dictionary["fullName"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? [String] ?? []
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
