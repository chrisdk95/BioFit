//
//  LoginViewController.swift
//  Biofit
//
//  Created by student on 10/26/20.
//

import UIKit
import FirebaseAuth



class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
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
    
    func showError(_ message:String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        //Validate text Fields
        
        
        //Assuming Textfields are valid
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //User Sign in
        Auth.auth().signIn(withEmail: email, password: password) {(user, error) in
            if (user != nil)
            {
            FirebaseUser.currentUserInstance.setCurrentUser(user: (user?.user.uid)!)
            print("Current User is \(FirebaseUser.currentUserInstance.getCurrentUser())")
            }
            if error != nil {
                self.showError("Email and Password Does not Match")
            }
            else
            {
                let tabBarController = self.storyboard?.instantiateViewController(identifier: "InitialViewController") as? UITabBarController
             
                self.view.window?.rootViewController = tabBarController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
        
}



