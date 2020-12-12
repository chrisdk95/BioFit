//
//  SignUpViewController.swift
//  Biofit
//
//  Created by student on 10/26/20.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

//Variables
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pass1TextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightFeetTextField: UITextField!
    @IBOutlet weak var heightInchesTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements()
    {
        errorLabel.alpha = 0
    }
    
    
    
    
//Check if fields are empty
    func validateFields() -> String?
    {
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || pass1TextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || weightTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || heightFeetTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || heightInchesTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
                {
                    return "Please fill in all fields."
                }
        return nil
    }
 
    
    func transitionToHome()
    {
       let tabBarController = storyboard?.instantiateViewController(identifier: "InitialViewController") as? UITabBarController
    
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
    
    func showError(_ message:String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    

    @IBAction func createAccountTapped(_ sender: Any)
    
    {
        let error = validateFields()
        
        if error != nil
        {
            showError(error!)
        }
    
         
        
        
        
        
        else
            {
                
                let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = pass1TextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let age = ageTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let weight = weightTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let heightFt = heightFeetTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let heightIn = heightInchesTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              
                //Create user
                Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
                    
                    //Check for errors
                        if err != nil
                        {
                            //If there was an error creating a user
                            self.showError("Error creating User")
                            
                        }
                        else
                        {
                            FirebaseUser.currentUserInstance.setCurrentUser(user: (user?.user.uid)!)
                            print("Current User is \(FirebaseUser.currentUserInstance.getCurrentUser())")
                            let userUid = FirebaseUser.currentUserInstance.getCurrentUser();
                            
                            FirebaseUser.currentUserInstance.createUserdata(userUid: userUid, firstName: firstName, lastName: lastName, age: age, weight: weight, heightFt: heightFt, heightIn: heightIn)
                    //Homescreen Transition
                            self.transitionToHome()
                            
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
}
