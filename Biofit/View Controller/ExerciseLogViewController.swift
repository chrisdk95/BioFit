//
//  ExerciseLogViewController.swift
//  Biofit
//
//  Created by student on 11/14/20.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ExerciseLogViewController: UIViewController {
    
    @IBOutlet weak var exerciseName: UITextField!
    
    @IBOutlet weak var exerciseDur: UITextField!
    @IBOutlet weak var calBurn: UITextField!
    
    @IBOutlet weak var totalMinutes: UITextField!
    @IBOutlet weak var totalCalories: UITextField!
    
    var finalExerciseName = ""
    var finalTotalMinutes = ""
    var finalTotalCalories = ""
    
    var defaultStore: Firestore?
    var location: [DocumentSnapshot] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: Selector(("OnAppBecameActive")), name: UIApplication.didBecomeActiveNotification, object: nil)

        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //all the code goes here
        let db = Firestore.firestore()
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let formatteddate = formatter.string(from: now)
        print(formatteddate);
        
     
        let userUid = FirebaseUser.currentUserInstance.getCurrentUser()
        
        let exceriseRef = db.collection("users").document(userUid).collection("Days").document(formatteddate).collection("exercise").document("entry");
        
        var exername: String?
        var exertime: String?
        var exercal: String?
        //var fullentry: String?
        var iscomplete = 0
        
        exceriseRef.getDocument{ (document,err ) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let aaa = document?.data()
                exername = aaa?["Name of Exercise"] as? String
                exertime = aaa?["How long"] as? String
                exercal = aaa?["Calories Burned"] as? String
                iscomplete = 1
                
                if ((iscomplete) != 0) {
                    print("hello world")
                    print(exername as Any)
                }
                
//                fullentry = "Exercise: \(exername ?? ""), Length: \(exertime ?? ""), Calories Burned: \(exercal ?? "")"
//
//                self.entry1.text = fullentry
                self.exerciseName.text = "Exercise Name: \(exername ?? "")"
                self.exerciseDur.text = "Time Spent: \(exertime ?? "")"
                self.calBurn.text = "Calories Burned \(exercal ?? "")"
            }
        }
       
    }
}

    
    
    
    
    
    

