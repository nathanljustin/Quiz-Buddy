//
//  EditQuestionViewController.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/12/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import Realm

class EditQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var answerText: UITextField!
    @IBOutlet weak var incorrectA: UITextField!
    @IBOutlet weak var incorrectB: UITextField!
    @IBOutlet weak var incorrectC: UITextField!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var quest: Question?
    var quiz: Quiz?
    var isCreating: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        questionText.text = quest?.question
        answerText.text = quest?.correct
        let inc = quest?.incorrect
        if isCreating == true {
            let string = RLMString()
            string.string = ""
            for _ in 0...2 { // Add 3 empty strings
                inc?.add(string)
            }
        }
            
        let incA = inc?.object(at: 0) as! RLMString
        incorrectA.text = incA.getString()
        let incB = inc?.object(at: 1) as! RLMString
        incorrectB.text = incB.getString()
        let incC = inc?.object(at: 2) as! RLMString
        incorrectC.text = incC.getString()
        
        if isCreating == true {
            navItem.title = "Create Question"
        }
        else {
            navItem.title = "Edit Question"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        quest?.question = questionText.text
        quest?.correct = answerText.text!
        let inc = quest?.incorrect
        
        let incA = inc?.object(at: 0) as! RLMString
        let incB = inc?.object(at: 1) as! RLMString
        let incC = inc?.object(at: 2) as! RLMString
        
        incA.setString(string: incorrectA.text!)
        incB.setString(string: incorrectB.text!)
        incC.setString(string: incorrectC.text!)
        
        if isCreating == true {
            quiz?.questions.insert(quest!, at: (quiz?.questions.count)!)
        }
        
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
