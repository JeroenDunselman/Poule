//
//  ViewController.swift
//  Poule
//
//  Created by Jeroen Dunselman on 29/05/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import UIKit

struct Power {
    //    public let strength: [Team: Int] = [Team.A: 0, Team.B: 33, Team.C: 66, Team.D: 100]
//        public let strength: [Team: Int] = [Team.A: 35, Team.B: 15, Team.C: 40, Team.D: 10]
//        public let strength: [Team: Int] = [Team.A: 75, Team.B: 80, Team.C: 95, Team.D: 100]
//    public let strength: [Team: Int] = [Team.A: 1, Team.B: 10, Team.C: 100, Team.D: 1000]
//        public let strength: [Team: Int] = [Team.A: 5, Team.B: 10, Team.C: 15, Team.D: 100]
                 public var strength: [Team: Int] = [Team.A: 25, Team.B: 25, Team.C: 25, Team.D: 25]
}

class ViewController: UIViewController {
    
    @IBAction func sliderA(_ sender: UISlider) {
        run.power.strength[Team.A] = Int(sender.value)
    }
    @IBAction func sliderB(_ sender: UISlider) {
        run.power.strength[Team.B] = Int(sender.value)
    }
    @IBAction func sliderC(_ sender: UISlider) {
        run.power.strength[Team.C] = Int(sender.value)
    }
    @IBAction func sliderD(_ sender: UISlider) {
        run.power.strength[Team.D] = Int(sender.value)
    }
    
    @IBOutlet weak var pouleResults: UITextView!
    @IBOutlet weak var teamResult: UITextView!
    
    let run = MultiRun()
    
    @IBAction func runButton(_ sender: Any) {
        run.run()
        run.report()
        pouleResults.text = run.pouleResults
        teamResult.text = run.teamResult
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        teamResult.isEditable = false
        
    }
}


