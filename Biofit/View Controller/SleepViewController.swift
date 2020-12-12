import UIKit
import FirebaseFirestore


class SleepViewController: UIViewController, UITabBarControllerDelegate {
    
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelArray: UILabel!
    @IBOutlet weak var firstProgressView: UIProgressView!
    @IBOutlet weak var secondProgressView: UIProgressView!
    
    var labelSegue = ""
    var intLabelSegue = 0
    var firstTransPoint = 0
    var secondTransPoint = 0
    var thirdTransPoint = 0
    var fourthTransPoint = 0
    var totalTransPoints = 0
    var helpArray: [String] = []
    var printArray: [String] = []
    
    var sleepHours: String = ""
    var sleepPoints: Int = 0
    var firstPoint: Int = 0
    var secondPoint: Int = 0
    var thirdPoint: Int = 0
    var fourthPoint: Int = 0
    
    
    let progress = Progress(totalUnitCount: 10)
    let secondProgress = Progress(totalUnitCount: 4)
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        firstProgressView.transform = firstProgressView.transform.scaledBy(x: 1, y: 5)
        
        secondProgressView.transform = secondProgressView.transform.scaledBy(x: 1, y: 5)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        helpArray = []
        
        self.progress.completedUnitCount = 0
        secondProgress.completedUnitCount = 0
    
        
        let db = Firestore.firestore()
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let formatteddate = formatter.string(from: now)
        print(formatteddate);
        
     
        let userUid = FirebaseUser.currentUserInstance.getCurrentUser()
        
        let sleepRef = db.collection("users").document(userUid).collection("Days").document(formatteddate).collection("sleep").document("entry");
        
        
        //var fullentry: String?
        var iscomplete = 0
        
        sleepRef.getDocument{ [self] (document,err ) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let sleep = document?.data()
                sleepHours = sleep?["hoursSlept"] as? String ?? ""
                sleepPoints = sleep?["totalPoints"] as? Int ?? 0
                firstPoint = sleep?["firstPoint"] as? Int ?? 0
                secondPoint = sleep?["secondPoint"] as? Int ?? 0
                thirdPoint = sleep?["thirdPoint"] as? Int ?? 0
                fourthPoint = sleep?["fourthPoint"] as? Int ?? 0
                iscomplete = 1
                
                if ((iscomplete) != 0) {
                    print(sleepHours as Any)
                    print(sleepPoints as Any)
                }
                
                labelSegue = sleepHours
                totalTransPoints = sleepPoints
                firstTransPoint = firstPoint
                secondTransPoint = secondPoint
                thirdTransPoint = thirdPoint
                fourthTransPoint = fourthPoint
                
                
                
                print(labelSegue)
                
                
                
                
                        
                
                
                //totalTransPoints = firstTransPoint + secondTransPoint + thirdTransPoint + fourthTransPoint
                
                labelOne.text = "Your SLEEP TIME score is: \(labelSegue) out of 10 hours."
                
                labelTwo.text = "Your SLEEP QUALITY score is: \(totalTransPoints) out of 4 pts."
                
                if (firstTransPoint == 0) {
                    helpArray.append("One indicator of healthy sleep quality is how long it takes you to fall asleep. As many as 27 percent of people take longer than a half-hour to fall asleep, but drifting off in 30 minutes or less is generally an indicator of high-quality sleep.")
                    helpArray.append("\u{0085} \u{0085}")
                }
                if (secondTransPoint == 0) {
                    helpArray.append("The total number of minutes you’re awake after initially falling asleep is another indicator of sleep quality. Twenty minutes or less is the goal.")
                    helpArray.append("\u{0085} \u{0085}")
                }
                if (thirdTransPoint == 0) {
                    helpArray.append("You may spend 8 hours in bed, but that doesn’t necessarily mean that you slept that amount. To maximize the health benefits, aim to spend at least 85 percent of your time in bed asleep. To determine this percent, take the total amount of time you spent in bed (in minutes) and subtract the number of minutes it took to fall asleep plus the minutes you spent awake throughout the night. This equals your total sleep time. Divide sleep time by total time in bed to determine your percentage.")
                    helpArray.append("\u{0085} \u{0085}")
                }
                if (fourthTransPoint == 0) {
                    helpArray.append("Waking often throughout the night (perhaps due to drinking alcohol before bed or having caffeine too late in the day) disrupts your sleep cycle, leaving you tired the next day. The standard for good sleep quality is waking once during the night, if at all.")
                }

                labelArray.text = ("\(helpArray)")
                
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                    guard self.progress.isFinished == false else {
                        timer.invalidate()
                        return
                    }
                    self.progress.completedUnitCount += 1
                    let progressFloat = Float(self.progress.fractionCompleted)
                    self.firstProgressView.setProgress(progressFloat, animated: true)
                    let fakeString = String(self.progress.completedUnitCount)
                    if ((fakeString.elementsEqual(self.labelSegue)) == true) {
                        timer.invalidate()
                        if ((fakeString.elementsEqual("0")) == true){
                            self.firstProgressView.progressTintColor = UIColor.red
                        } else if ((fakeString.elementsEqual("1")) == true) {
                            self.firstProgressView.progressTintColor = UIColor.red
                        } else if ((fakeString.elementsEqual("2")) == true) {
                            self.firstProgressView.progressTintColor = UIColor.red
                        } else if ((fakeString.elementsEqual("3")) == true) {
                            self.firstProgressView.progressTintColor = UIColor.orange
                        } else if ((fakeString.elementsEqual("4")) == true) {
                            self.firstProgressView.progressTintColor = UIColor.orange
                        } else if ((fakeString.elementsEqual("5")) == true) {
                            self.firstProgressView.progressTintColor = UIColor.yellow
                        } else if ((fakeString.elementsEqual("6")) == true) {
                            self.firstProgressView.progressTintColor = UIColor.yellow
                        } else if ((fakeString.elementsEqual("7")) == true) {
                            self.firstProgressView.progressTintColor = UIColor.green
                        } else if ((fakeString.elementsEqual("8")) == true) {
                            self.firstProgressView.progressTintColor = UIColor.green
                        } else if ((fakeString.elementsEqual("9")) == true) {
                            self.firstProgressView.progressTintColor = UIColor.green
                        } else if ((fakeString.elementsEqual("10")) == true) {
                            self.firstProgressView.progressTintColor = UIColor.green
                        }
                    }
                }
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                    guard self.secondProgress.isFinished == false else {
                        timer.invalidate()
                        return
                    }
                    secondProgress.completedUnitCount += 1
                    let progressFloat = Float(secondProgress.fractionCompleted)
                    secondProgressView.setProgress(progressFloat, animated: false)
                    if secondProgress.completedUnitCount == self.totalTransPoints {
                        timer.invalidate()
                        if (self.totalTransPoints <= 1) {
                            secondProgressView.progressTintColor = UIColor.red
                        } else if (self.totalTransPoints == 2 ){
                            secondProgressView.progressTintColor = UIColor.orange
                        } else if (self.totalTransPoints == 3 ){
                            secondProgressView.progressTintColor = UIColor.yellow
                        } else if (self.totalTransPoints == 4 ){
                            secondProgressView.progressTintColor = UIColor.green
                        }
                    }
                }
                
            }
           
        }
        
    }
    
    
    
    
}
