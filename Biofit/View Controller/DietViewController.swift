import UIKit
import FirebaseFirestore

private let reuseIdentifier = "foodTableViewCell"



class DietViewController: UIViewController {
   
    struct Foods {
        var foodName: String
        var calories: Int
    }
    
    
    
    @IBOutlet weak var breakfastField: UITextField!
    @IBOutlet weak var lunchField: UITextField!
    @IBOutlet weak var dinnerField: UITextField!
    @IBOutlet weak var foodloabel: UILabel!
    @IBOutlet weak var addfoodbutton: UIButton!
    @IBOutlet weak var foodTableView: UITableView!
    
    var foodName: String?
    var foodCal: String?

    var foods = [Foods]();
    //var foods = Foods(foodName: "banana", calories: 32)
    
    
   override func viewDidLoad() {
    super.viewDidLoad()
//        foodTableView.delegate = self
//        foodTableView.dataSource = self
    
    
   }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let db = Firestore.firestore()
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let formatteddate = formatter.string(from: now)
        print(formatteddate);
        
     
        let userUid = FirebaseUser.currentUserInstance.getCurrentUser()
        
        let breakfastRef = db.collection("users").document(userUid).collection("Days").document(formatteddate).collection("diet").document("Breakfast");
        
        breakfastRef.getDocument{ (document,err ) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let food = document?.data()
                self.foodName = food?["foodName"] as? String
                self.foodCal = food?["foodCal"] as? String
                print(self.foodName as Any)
                
                if (self.foodName != nil) {
                self.breakfastField.text = "Meal: \(self.foodName ?? ""), Cal: \(self.foodCal ?? "")"
                }
            }
        }
        
        let lunchRef = db.collection("users").document(userUid).collection("Days").document(formatteddate).collection("diet").document("Lunch");
        
        lunchRef.getDocument{ (document,err ) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let food = document?.data()
                self.foodName = food?["foodName"] as? String
                self.foodCal = food?["foodCal"] as? String
                print("Lunch: \(self.foodName as Any)")
                
                if (self.foodName != nil) {
                self.lunchField.text = "Meal: \(self.foodName ?? ""), Cal: \(self.foodCal ?? "")"
                }
            }
        }
        
        let dinnerRef = db.collection("users").document(userUid).collection("Days").document(formatteddate).collection("diet").document("Dinner");
        
        dinnerRef.getDocument{ (document,err ) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let food = document?.data()
                self.foodName = food?["foodName"] as? String
                self.foodCal = food?["foodCal"] as? String
                print(self.foodName as Any)
                if (self.foodName != nil)
                {
                self.dinnerField.text = "Meal: \(self.foodName ?? ""), Cal: \(self.foodCal ?? "")"
                }
            }
        }

        
        
    }
    
    

}
