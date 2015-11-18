//
//  ViewController.swift
//  flatnote
//
//  Created by Steven Zazeski on 10/27/15.
//  Copyright © 2015 Steven Zazeski. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var animateFlatNoteImage: NSLayoutConstraint!
    @IBOutlet weak var animateFlatNoteLabel: NSLayoutConstraint!
    @IBOutlet weak var animateStartLeading: NSLayoutConstraint!
    @IBOutlet weak var animateStartTrailing: NSLayoutConstraint!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var initialConstraints: [CGFloat] = []
    var constraints : [NSLayoutConstraint] = []
    
    let app = UIApplication.sharedApplication().delegate as! flatNote
    
// ---------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        constraints = [animateFlatNoteImage, animateFlatNoteLabel, animateStartLeading, animateStartTrailing]
        saveInitialConstraints()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        highScoreLabel.text = "\(app.highScore)"
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        resetInitialConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// ---------

    @IBAction func clickedStart(sender: AnyObject) {
        
        UIView.animateWithDuration(0.25, delay:0, options: .CurveEaseOut, animations: {
            self.animateFlatNoteImage.constant = 500;
            self.animateFlatNoteLabel.constant = 500;
            self.animateStartLeading.constant = 400;
            self.animateStartTrailing.constant = -500;
            
            self.view.layoutIfNeeded()
            },completion: animationCompleted)
    }
    
    func animationCompleted(done: Bool) {
        self.performSegueWithIdentifier("startGame", sender: self)
    }
    
    func saveInitialConstraints() {
        initialConstraints = []
        for i in constraints {
            initialConstraints.append(i.constant)
        }
    }
    func resetInitialConstraints() {
        for (i,c) in constraints.enumerate() {
            c.constant = initialConstraints[i]
        }
    }
}
