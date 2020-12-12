//
//  SleepInputViewController.swift
//  Biofit
//
//  Created by Manuel Gavino on 12/2/20.
//

import UIKit
import FirebaseFirestore


class SleepInputViewController: UIViewController {
    
    @IBOutlet weak var inputOne: UITextField!
    
    var textSegue = ""
    var firstPointsSystem = 0
    var secondPointsSystem = 0
    var thirdPointsSystem = 0
    var fourthPointsSystem = 0
    var totalPoints = 0
    
    @IBOutlet weak var firstSegmentedControl: UISegmentedControl!
    @IBOutlet weak var secondSegmentedControl: UISegmentedControl!
    @IBOutlet weak var thirdSegmentedControl: UISegmentedControl!
    @IBOutlet weak var fourthSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func enterButton(_ sender: Any) {
        self.textSegue = inputOne.text!
        
        
        
        
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let formatteddate = formatter.string(from: now)
        
        //Authenticate User
        //guard let userID = Auth.auth().currentUser?.uid
        //else { return }
        let firebaseUser = FirebaseUser.currentUserInstance;
        
        let userUID = firebaseUser.getCurrentUser()
        
        //Initialize Firestore
        let db = Firestore.firestore()
        let days = formatteddate
                
        totalPoints = firstPointsSystem + secondPointsSystem + thirdPointsSystem + fourthPointsSystem
        print(firstPointsSystem)
        print(totalPoints)
                
        db.collection("users").document(userUID).collection("Days").document("\(days)").collection("sleep").document("entry").setData(["hoursSlept": textSegue,"totalPoints": totalPoints, "firstPoint": firstPointsSystem, "secondPoint": secondPointsSystem, "thirdPoint": thirdPointsSystem, "fourthPoint": fourthPointsSystem]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
              

        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func firstIndexChanged(_ sender: Any) {
        switch firstSegmentedControl.selectedSegmentIndex {
        case 0:
            firstPointsSystem = 0
        case 1:
            firstPointsSystem = 1
        case 2:
            firstPointsSystem = 0
        default:
            break
        }
    }
    
    @IBAction func secondIndexChanged(_ sender: Any) {
        switch secondSegmentedControl.selectedSegmentIndex {
        case 0:
            secondPointsSystem = 0
        case 1:
            secondPointsSystem = 0
        case 2:
            secondPointsSystem = 1
        default:
            break
        }
    }
    
    @IBAction func thirdIndexChanged(_ sender: Any) {
        switch thirdSegmentedControl.selectedSegmentIndex {
        case 0:
            thirdPointsSystem = 0
        case 1:
            thirdPointsSystem = 1
        case 2:
            thirdPointsSystem = 0
        default:
            break
        }
    }
    
    @IBAction func fourthIndexChanged(_ sender: Any) {
        switch fourthSegmentedControl.selectedSegmentIndex {
        case 0:
            fourthPointsSystem = 0
        case 1:
            fourthPointsSystem = 0
        case 2:
            fourthPointsSystem = 1
        default:
            break
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var vc = segue.destination as! SleepViewController
//        vc.labelSegue = self.textSegue
//        vc.firstTransPoint = self.firstPointsSystem
//        vc.secondTransPoint = self.secondPointsSystem
//        vc.thirdTransPoint = self.thirdPointsSystem
//        vc.fourthTransPoint = self.fourthPointsSystem
//    }
//
    
}
