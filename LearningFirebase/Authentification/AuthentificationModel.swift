//
//  AuthentificationModel.swift
//  LearningFirebase
//
//  Created by Pascal Allekotte on 01.06.24.
//

import Foundation
import FirebaseAuth

struct AuthentificationModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
    
}
