//
//  ScoreViewController.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/15/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var outOfLabel: UILabel!
    @IBOutlet weak var prevScoreLabel: UILabel!
    
    
    var quiz: Quiz?
    var score: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Write new prevScore here
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scoreLabel.text = String(describing: score!)
        outOfLabel.text = "out of \(String(describing: (quiz?.questions.count)!))"
        prevScoreLabel.text = "Previous Score: \(String(describing: (quiz?.prevScore)!))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func homeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
*/
}
