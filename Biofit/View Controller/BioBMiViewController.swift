//
//  BioBMiViewController.swift
//  Biofit
//
//  Created by student on 11/11/20.
//

import UIKit
import FirebaseFirestore

class BioBMiViewController: UIViewController {
    @IBOutlet weak var HeightFt: UITextField!
    @IBOutlet weak var HeightIn: UITextField!
    @IBOutlet weak var Weight: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var BMIOutput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements()
    {
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String?
    {
        
        if HeightFt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || HeightIn.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || Weight.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        return nil
    }
    
    
    
    func showError(_ message:String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    @IBAction func BtnCalculate(_ sender: UIButton) {
        
        let error = validateFields()
        
        if error != nil
        {
            showError(error!)
        }
        
        else
        {
        
        // Input
        let heightFt = Double(HeightFt.text!)
        let heightIn = Double(HeightIn.text!)
        let weight = Double(Weight.text!)
        

        let totalHeight = Double((heightFt! * 12) + heightIn!)
        let heightSquared = (totalHeight * totalHeight)
        
        
        //Processing: Formula for calculationg BMI
        let bmi = Double(703 * weight!) / (heightSquared)
        
        // Output:
        BMIOutput.text = "Your BMI score is: " + String(format: "%.2f", bmi)
            
            
            
            
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let formatteddate = formatter.string(from: now)
        
        let firebaseUser = FirebaseUser.currentUserInstance;
        
        let userUID = firebaseUser.getCurrentUser()
        
        //Initialize Firestore
        let db = Firestore.firestore()
        let days = formatteddate
        let error = validateFields()
    
        if error != nil
        {
            showError(error!)
        }
        
        else
        {
            db.collection("users").document(userUID).collection("Days").document("\(days)").collection("bio").document("entry").setData(["BMI": String(format: "%.2f", bmi)]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }//End of else condition
        
        }
        
        
    }
    
  

}
