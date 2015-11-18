//
//  GameViewController.swift
//  flatnote
//
//  Created by Steven Zazeski on 10/27/15.
//  Copyright © 2015 Steven Zazeski. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreUpdate: UILabel!
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    @IBOutlet weak var noteAoffset: NSLayoutConstraint!
    
    let app = UIApplication.sharedApplication().delegate as! flatNote
    
    var currentNote = ""
    var score = 0
    var potentialPoints = 5

    
    var allowedNotes = ["F","A","C","E"]
    var offsetNotes: [CGFloat] = [70.0,22.0,-20.0,-65.0]
    
    var timerNext = NSTimer()
    
// -------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        scoreLabel.text = "0"
        scoreUpdate.text = ""
        levelLabel.text = "Level \(app.level)"
        
        randomizeAllowedNotes()
        randomizeKeys()
        nextNote()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if score > app.highScore {
            app.highScore = score
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// -------------------------
    
    func timerTicked() {
        potentialPoints--
        
        if potentialPoints == 0 {
            scoreUpdate(-1)
            nextNote()
        }else{
            timerNext = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerTicked", userInfo: nil, repeats: false)
        }
    }
    
    func scoreUpdate(changeBy:Int) {
        score = score + changeBy
        if changeBy > 0 {
            scoreUpdate.text = "+\(changeBy)"
            scoreUpdate.textColor = UIColor.greenColor()
        }else{
            scoreUpdate.text = "\(changeBy)"
            scoreUpdate.textColor = UIColor.redColor()
        }
        scoreLabel.text = "\(score)"
        potentialPoints = 5
    }
    
    func nextNote() {
        timerNext.invalidate()
        
        let sizeOfAllowedNotes = UInt32(allowedNotes.endIndex)
        var newNote = currentNote
        var random = 0
        
        while(newNote == currentNote){
            random = Int(arc4random_uniform(sizeOfAllowedNotes))
            newNote = allowedNotes[random]
            print(".", terminator: "")
        }
        
        currentNote = newNote
        noteAoffset.constant = offsetNotes[random]
        print(currentNote)
        timerNext = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerTicked", userInfo: nil, repeats: false)
    }
    
    func checkIfCorrect(num:Int){
        if currentNote == allowedNotes[num] {
            scoreUpdate(potentialPoints)
        }else{
            scoreUpdate(0-potentialPoints)
        }
        nextNote()
    }
    
    @IBAction func clickedButtonA(sender: AnyObject) {
        checkIfCorrect(0)
    }
    
    @IBAction func clickedButtonB(sender: AnyObject) {
        checkIfCorrect(1)
    }
    
    @IBAction func clickedButtonC(sender: AnyObject) {
        checkIfCorrect(2)
    }
    
    @IBAction func clickedButtonD(sender: AnyObject) {
        checkIfCorrect(3)
    }

    @IBAction func clickedBack(sender: AnyObject) {
        timerNext.invalidate()
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    func randomizeKeys() {
        shuffleArray(5)
        
        buttonA.setTitle(allowedNotes[0], forState: .Normal)
        buttonB.setTitle(allowedNotes[1], forState: .Normal)
        buttonC.setTitle(allowedNotes[2], forState: .Normal)
        buttonD.setTitle(allowedNotes[3], forState: .Normal)
    }
    
    func randomizeAllowedNotes() {
        
        var possibleNotes: [Note] = []
        
        // get 4 notes in the correct level for user
        for i in app.newNotes {
            if i.level == app.level {
                possibleNotes.append(i)
            }
        }
        
        for i in 0...3 {
            let random = Int(arc4random_uniform(UInt32(possibleNotes.endIndex)))
            
            allowedNotes[i] = possibleNotes[random].name
            offsetNotes[i] = possibleNotes[random].offset
            possibleNotes.removeAtIndex(random)
        }
        
    }
    
    func shuffleArray(quality: Int) {
        print("starting = \(allowedNotes)")
        let size = UInt32(allowedNotes.endIndex)
        
        for i in 0..<allowedNotes.endIndex {
            let random = Int(arc4random_uniform(size))
            
            let temp = allowedNotes[i]
            allowedNotes[i] = allowedNotes[random]
            allowedNotes[random] = temp
            
            let tempB = offsetNotes[i]
            offsetNotes[i] = offsetNotes[random]
            offsetNotes[random] = tempB
        }
        print("shuffled = \(allowedNotes)")
    }
    
    
}
