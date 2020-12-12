import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ExerciseAddViewController: UIViewController {
    @IBOutlet weak var nameOfExercise: UITextField!
    @IBOutlet weak var howLong: UITextField!
    @IBOutlet weak var caloriesBurned: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
  
    //To hide pop up error Label when simulation is running
    func setUpElements()
    {
        errorLabel.alpha = 0
    }
    
    //Check if fields are all filled
    func validateFields() -> String?
    {
        
        if nameOfExercise.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || howLong.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || caloriesBurned.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        return nil
    }
    
    
    //Show error label that was hidden
    func showError(_ message:String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    
    @IBAction func doneBtnTapped(_ sender: Any) {
        
        
        /*let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let formatteddate = formatter.string(from: now)
        howLong.text = formatteddate
        */
        
        let nOE = nameOfExercise.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let mntsEx = howLong.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let calB = caloriesBurned.text!.trimmingCharacters(in: .whitespacesAndNewlines)
   
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

        
        
       
        let error = validateFields()
        
        if error != nil
        {
            showError(error!)
        }
        
        
        else
            {
                

                
                db.collection("users").document(userUID).collection("Days").document("\(days)").collection("exercise").document("entry").setData(["Name of Exercise": nOE,"How long": mntsEx, "Calories Burned" : calB]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
              
            
            
            
            
            
            
            
            }//End of else condition
        
        

        
        

        
    // db.collection("users").document("UID")
    //howLong.text = userID
        
        
        
        
        //Go to Previous Screen
        self.navigationController?.popViewController(animated: true)
    }

}

