//
//  SettingsViewController.swift
//  flatnote
//
//  Created by Steven Zazeski on 10/27/15.
//  Copyright © 2015 Steven Zazeski. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelStepper: UIStepper!
    
    let app = UIApplication.sharedApplication().delegate as! flatNote
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appVersionNumber = String(NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]!)
        let appVersionBuild = String(NSBundle.mainBundle().infoDictionary!["CFBundleVersion"]!)
        versionLabel.text = "version \(appVersionNumber) build \(appVersionBuild)"
        
        levelStepper.value = Double(app.level)
    }
    
    override func viewWillAppear(animated: Bool) {
        levelLabel.text = "\(app.level)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clickedBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func changeLevel(sender: AnyObject) {
        app.level = Int(levelStepper.value)
        levelLabel.text = "\(app.level)"
    }
}
