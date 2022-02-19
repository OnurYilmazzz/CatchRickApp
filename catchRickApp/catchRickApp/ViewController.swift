//
//  ViewController.swift
//  catchRickApp
//
//  Created by onur yılmaz on 19.02.2022.
//

import UIKit

class ViewController: UIViewController {
  // Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var rickArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    // Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var rick1: UIImageView!
    @IBOutlet weak var rick2: UIImageView!
    @IBOutlet weak var rick3: UIImageView!
    @IBOutlet weak var rick4: UIImageView!
    @IBOutlet weak var rick5: UIImageView!
    @IBOutlet weak var rick6: UIImageView!
    @IBOutlet weak var rick7: UIImageView!
    @IBOutlet weak var rick8: UIImageView!
    @IBOutlet weak var rick9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text="Score: \(score)"
        
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore : \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "HighScore : \(highScore)"
        }
        // Rick images
        rick1.isUserInteractionEnabled = true
        rick2.isUserInteractionEnabled = true
        rick3.isUserInteractionEnabled = true
        rick4.isUserInteractionEnabled = true
        rick5.isUserInteractionEnabled = true
        rick6.isUserInteractionEnabled = true
        rick7.isUserInteractionEnabled = true
        rick8.isUserInteractionEnabled = true
        rick9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        
        rick1.addGestureRecognizer(recognizer1)
        rick2.addGestureRecognizer(recognizer2)
        rick3.addGestureRecognizer(recognizer3)
        rick4.addGestureRecognizer(recognizer4)
        rick5.addGestureRecognizer(recognizer5)
        rick6.addGestureRecognizer(recognizer6)
        rick7.addGestureRecognizer(recognizer7)
        rick8.addGestureRecognizer(recognizer8)
        rick9.addGestureRecognizer(recognizer9)
        
        rickArray = [rick1,rick2,rick3,rick4,rick5,rick6,rick7,rick8,rick9]
        
        //Timers
        counter = 30
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideRick), userInfo: nil, repeats: true)
        
        hideRick()
    }
   @objc func hideRick(){
        for rick in rickArray{
            rick.isHidden = true // rickleri gizledik.
        }
       let random = Int (arc4random_uniform(UInt32(rickArray.count - 1))) // random sayı oluşturuyoruz.
        rickArray[random].isHidden = false   // gizlenmiş ricklerden random bir tanesini gösteriyoruz.
    }
    
    @objc func increaseScore(){
       score += 1
        scoreLabel.text = "Score:  \(score)"
    }
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for rick in rickArray{
                rick.isHidden = true
                
            }
            // High score
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "HighScore : \(highScore) "
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            // Alert mesajı
            
            let alert = UIAlertController(title: "Game over", message: "Do you want play again", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title:" Replay", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideRick), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}

