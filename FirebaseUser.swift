//
//  FirebaseUser.swift
//  Biofit
//
//  Created by Manuel Gavino on 11/13/20.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


let db = Firestore.firestore()

public class FirebaseUser {
    var currentUser: String?
    
    static let currentUserInstance = FirebaseUser()
    
    func setCurrentUser(user currentUser: String){
        self.currentUser = currentUser
    }
    
    func getCurrentUser() -> String {
        return self.currentUser!
    }
    
    
    func createUserdata(userUid: String, firstName: String,lastName: String, age: String, weight: String, heightFt: String, heightIn: String) {
        db.collection("users").document(userUid)
            .setData([
                        "uid": userUid,
                        "firstName":firstName,
                        "lastName":lastName,
                        "Age":age,
                        "Weight": weight,
                        "Height(Feet)":heightFt,
                        "Height(Inches)":heightIn])
        {(error) in
            if error != nil {
                print("User Data Collection Failed")
            }
    }

    }
    
}
