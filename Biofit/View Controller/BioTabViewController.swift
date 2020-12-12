//
//  BioTabViewController.swift
//  Biofit
//
//  Created by student on 12/2/20.
//

import UIKit
import FirebaseFirestore

class BioTabViewController: UIViewController {
    
    @IBOutlet weak var bmiTextField: UITextField!
   
    @IBOutlet weak var heartRateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        let bioRef = db.collection("users").document(userUid).collection("Days").document(formatteddate).collection("bio").document("entry");
        let hrRef = db.collection("users").document(userUid).collection("Days").document(formatteddate).collection("bio").document("HR");
        
        var bmi: String?
        var heartRate: String?
        
        bioRef.getDocument{ (document,err ) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let aaa = document?.data()
                bmi = aaa?["BMI"] as? String
                
                
                self.bmiTextField.text = "BMI: \(bmi ?? "")"
            }
        }
        
        hrRef.getDocument{ (document,err ) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let aaa = document?.data()
                heartRate = aaa?["heartRate"] as? String
                
                
                self.heartRateTextField.text = "Heart Rate: \(heartRate ?? "")"
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
