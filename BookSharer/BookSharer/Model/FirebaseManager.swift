//
//  FirebaseManager.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/28.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class FirebaseManager: NSObject {
    
    let auth: FirebaseAuth.Auth
    let storage: Storage
    let firestore: Firestore
    
    var currentUser: User?
    
    static let shared = FirebaseManager()
    
    override init() {
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
}
