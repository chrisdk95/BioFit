//
//  models.swift
//  Biofit
//
//  Created by Manuel Gavino on 11/30/20.
//

import Foundation
import FirebaseFirestore
import Firebase

struct ExerciseModel {
    
    var documentId: String?
    var exerciseName: String?
    var exerciseTime: String?
    var exericseBurned: String?
    
    var dictionary:  [String:Any] {
        return [
            "exerciseName": exerciseName ?? "",
            "exerciseTime": exerciseTime  ?? "",
            "exerciseBurned": exericseBurned ?? ""
        ]
    }
    
    init(snapshot: DocumentSnapshot) {
        documentId = snapshot.documentID
        let snapshotValue = snapshot.data()
        exerciseName = snapshotValue?["Name of Exercise"] as? String
        exerciseTime = snapshotValue?["How long"] as? String
        exericseBurned = snapshotValue?["Calories Burned"] as?  String
    }
}

struct FoodModel {
    
    var foodName: String?
    var foodCal: String?
    
    var dictionary: [String:Any] {
        return [
            "foodName": foodName ?? "",
            "foodCal": foodCal ?? ""
        ]
    }
    
    init(snapshot: DocumentSnapshot) {
        let snapShotValue = snapshot.data()
        foodName = snapShotValue?["foodName"] as? String
        foodCal = snapShotValue?["foodCal"] as? String
    }
}
