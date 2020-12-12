//
//  AddFoodViewController.swift
//  Biofit
//
//  Created by Manuel Gavino on 11/30/20.
//

import UIKit
import FirebaseFirestore



class AddFoodViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
    }
    
    func setUpElements()
    {
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String?
    {
        
        if calorieTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || foodNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
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
    
    

    
    var mealTypestring: String? = "Breakfast"
    
    @IBAction func mealTypeButton(_ sender: Any) {
        switch mealType.selectedSegmentIndex {
        case 0:
            mealTypestring = "Breakfast"
        case 1:
            mealTypestring = "Lunch"
        case 2:
            mealTypestring = "Dinner"
        default:
            break
        }
        
    }

    @IBOutlet weak var doneButton1: UIButton!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var calorieTextField: UITextField!
    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    @IBAction func cancel(segue:UIStoryboardSegue) {

    }

    @IBOutlet weak var mealType: UISegmentedControl!
    
    
    
    
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
     /*   if(foodNameTextField.text!.isEmpty || calorieTextField.text!.isEmpty){
        //Output an Alert
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Please fill out all information"
            alert.show()
        }
 */
        let error = validateFields()
        
        if error != nil
        {
            showError(error!)
        }
        
        else {
            let name = foodNameTextField.text!
            let calorie = calorieTextField.text!
            
            //Today's Date
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

         db.collection("users").document(userUID).collection("Days").document("\(days)").collection("diet").document("\(mealTypestring ?? "")")
                .setData(["foodName": name, "foodCal" : calorie]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
                    


            

            self.navigationController?.popViewController(animated: true)
        
        
    }
    }
    //    @IBAction func done(segue:UIStoryboardSegue) {
//        if(foodNameTextField.text!.isEmpty || calorieTextField.text!.isEmpty){
//        //Output an Alert
//            let alert = UIAlertView()
//            alert.title = "Error"
//            alert.message = "Please fill out all information"
//            alert.show()
//        }
//        else {
//            let name = foodNameTextField.text!
//            let calorie = Int(calorieTextField.text!)
//            let food = Foods(foodName: name, calories: calorie!)
//
//            delegate?.addFood(food: food)
//
//            self.navigationController?.popViewController(animated: true)
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
