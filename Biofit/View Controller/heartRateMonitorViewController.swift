//
//  heartRateMonitorViewController.swift
//  Biofit
//
//  Created by student on 11/12/20.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class heartRateMonitorViewController: UIViewController {
    
    var seconds = 30
    var timer = Timer()

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var hrInput: UITextField!
    
    @IBOutlet weak var calButton: UIButton!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBAction func slider(_ sender: UISlider)
    {
        seconds = Int(sender.value)
        label.text = String(seconds) + " Seconds"
    }
    
    @IBOutlet weak var startOutlet: UIButton!
    @IBAction func start(_ sender: AnyObject)
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(heartRateMonitorViewController.counter), userInfo: nil, repeats: true)
        
        sliderOutlet.isHidden = true
        startOutlet.isHidden = true
    }
    
    @objc func counter()
     {
        seconds -= 1
        label.text = String(seconds) + " Seconds"
        
        if (seconds == 0)
        {
            timer.invalidate()
        }
     }
    
    @IBOutlet weak var stopOutlet: UIButton!
    @IBAction func stop(_ sender: AnyObject)
    {
        timer.invalidate()
        seconds = 30
        sliderOutlet.setValue(30, animated : true)
        label.text = "30 seconds"
        
        sliderOutlet.isHidden = false
        startOutlet.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func isCalculate(_ sender: Any) {
        let heartRate = hrInput.text!
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let formatteddate = formatter.string(from: now)
        
        let firebaseUser = FirebaseUser.currentUserInstance;
        
        let userUID = firebaseUser.getCurrentUser()
        
        //Initialize Firestore
        let db = Firestore.firestore()
        let days = formatteddate
        
      
        db.collection("users").document(userUID).collection("Days").document("\(days)").collection("bio").document("HR").setData(["heartRate": heartRate]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

}
