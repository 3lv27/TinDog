//
//  DataBaseService.swift
//  tinDog
//
//  Created by Elvin Gomez on 22/05/2018.
//  Copyright © 2018 Elvin Gomez. All rights reserved.
//

import Foundation
import Firebase

let DB_ROOT = Database.database().reference()


class DataBaseService {
    static let instance = DataBaseService()
    
    private let _BaseRef = DB_ROOT
    private let _UserRef = DB_ROOT.child("users")
    
    var BaseRef: DatabaseReference {
        return _BaseRef
    }
    
    var UserRef: DatabaseReference {
        return _UserRef
    }
    
    func createUser(uid: String, userData: Dictionary<String, Any>) {
        UserRef.child(uid).updateChildValues(userData)
    }
    
}
