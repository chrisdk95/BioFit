//
//  ProfileViewController.swift
//  Biofit
//
//  Created by Manuel Gavino on 11/12/20.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore





class ProfileViewController: UIViewController {
   
    @IBOutlet weak var inputdate: UITextField!
    @IBOutlet weak var entryName: UITextField!
    @IBOutlet weak var entryWeight: UITextField!
    @IBOutlet weak var entryAge: UITextField!
    
    var defaultStore: Firestore?
    var location: [DocumentSnapshot] = []
    
    
    
    @IBOutlet weak var signoutbutton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    
    
    let now = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd-yyyy"
    let formatteddate = formatter.string(from: now)

  
    
    inputdate.text = formatteddate
    refreshView()
        
    }
    
    

    
    
    //When Signout is tapped
    @IBAction func Signout(_ sender: Any) {
        
        try! Auth.auth().signOut()
       
        transitionToLaunchScreen()
        
        
    /* Original
        //let welcomeViewController = ViewController()
        let welcomeNavigationController = UINavigationController(rootViewController: LaunchScreen)
        self.view.window?.rootViewController = welcomeNavigationController
        self.view.window?.makeKeyAndVisible()
    */
    }
    
    func transitionToLaunchScreen()
    {
        let launchScreenView = storyboard?.instantiateViewController(identifier: Constants.Storyboard.launchScreenView) as? UINavigationController
     
         view.window?.rootViewController = launchScreenView
         view.window?.makeKeyAndVisible()
    }
    
    func refreshView()
    {
        //all the code goes here
        let db = Firestore.firestore()
        
     /*   let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let formatteddate = formatter.string(from: now)
        print(formatteddate);
       
    */
     
        let userUid = FirebaseUser.currentUserInstance.getCurrentUser()
        
        let exceriseRef = db.collection("users").document(userUid);
        
        var fullName: String?
        var firstName: String?
        var lastName: String?
        var initialWeight: String?
        var age: String?
        //var fullentry: String?
        var iscomplete = 0
        
        exceriseRef.getDocument{ (document,err ) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let aaa = document?.data()
                firstName = aaa?["firstName"] as? String
                lastName = aaa?["lastName"] as? String
                fullName = "\(firstName ?? "")  \(lastName ?? "")"
                initialWeight = aaa?["Weight"] as? String
                age = aaa?["Age"] as? String
                iscomplete = 1
                
                if ((iscomplete) != 0) {
                    print("hello world")
                    print(fullName as Any)
                }
                
//                fullentry = "Exercise: \(exername ?? ""), Length: \(exertime ?? ""), Calories Burned: \(exercal ?? "")"
//
//                self.entry1.text = fullentry
                self.entryName.text = " \(fullName ?? "")"
                self.entryWeight.text = " \(initialWeight ?? "") Pounds"
                self.entryAge.text = " \(age ?? "") Years Old"
                
            }
        }
       
    }
    
    
}
