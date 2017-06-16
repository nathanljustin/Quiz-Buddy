//
//  EditQuestionViewController.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/12/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import RealmSwift

class EditQuestionViewController: UIViewController {
    // This class is for both creating and editing questions
    
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var answerText: UITextField!
    @IBOutlet weak var incorrectA: UITextField!
    @IBOutlet weak var incorrectB: UITextField!
    @IBOutlet weak var incorrectC: UITextField!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var deleteButton: UIButton!
    
    var quest: Question? // Current question
    var quiz: Quiz? // Current quiz
    var isCreatingQuest: Bool? // true if creating, not editing, a question
    var isCreatingQuiz: Bool? // true if creating, not editing, a quiz

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Set up display of question editor
    override func viewWillAppear(_ animated: Bool) {
        
        // Insert any previous text into text fields
        questionText.text = quest?.question
        answerText.text = quest?.correct
        
        // Insert incorrect answers
        let inc = quest?.incorrect
        
        if isCreatingQuest == true {
            // Add 3 empty strings for incorrect answers
            let string = RLMString()
            string.string = ""
            for _ in 0...2 {
                inc?.append(string)
            }
        }
        
        // Enter in incorrect answers to appropriate text fields
        let incA = inc?[0]
        incorrectA.text = incA?.getString()
        let incB = inc?[1]
        incorrectB.text = incB?.getString()
        let incC = inc?[2]
        incorrectC.text = incC?.getString()
        
        // Change title of screen appropriately
        if isCreatingQuest == true {
            navItem.title = "Create Question"
        }
        else {
            navItem.title = "Edit Question"
        }
        
        // If creating a question, hide the delete button
        if isCreatingQuest == true {
            deleteButton.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        // If creating a quiz, just add to the quiz
        // Otherwise, must write the edits to Realm
        if isCreatingQuiz == true {
            quest?.question = questionText.text
            quest?.correct = answerText.text!
            
            // Update all incorrect answers
            quest?.incorrect.removeAll()
        
            let incA = RLMString()
            incA.setString(string: incorrectA.text!)
            quest?.incorrect.append(incA)
        
            let incB = RLMString()
            incB.setString(string: incorrectB.text!)
            quest?.incorrect.append(incB)
        
            let incC = RLMString()
            incC.setString(string: incorrectC.text!)
            quest?.incorrect.append(incC)
        
            // If creating a question, append to questions list
            if isCreatingQuest == true {
                quiz?.questions.insert(quest!, at: (quiz?.questions.count)!)
            }
        }
        else {
            let realm = try! Realm()
            try! realm.write() {
                quest?.question = questionText.text
                quest?.correct = answerText.text!
                
                // Update all incorrect answers
                quest?.incorrect.removeAll()
                
                let incA = RLMString()
                incA.setString(string: incorrectA.text!)
                quest?.incorrect.append(incA)
                
                let incB = RLMString()
                incB.setString(string: incorrectB.text!)
                quest?.incorrect.append(incB)
                
                let incC = RLMString()
                incC.setString(string: incorrectC.text!)
                quest?.incorrect.append(incC)
                
                // If creating a question, append to questions list
                if isCreatingQuest == true {
                    quiz?.questions.insert(quest!, at: (quiz?.questions.count)!)
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        // Alert user that this is a permanent delete
        let alertController = UIAlertController(title: "Delete this Question?", message: "This action cannot be undone", preferredStyle: .alert)
        
        // Now adding actions to the alert controller
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: yesDelete))
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
        return

    }
    
    func yesDelete(action: UIAlertAction) {
        // Delete the question
        // Must write to Realm if question is on Realm
        if isCreatingQuiz == true {
            let index = quiz?.questions.index(of: quest!)
            quiz?.questions.remove(objectAtIndex: index!)
        }
        else if isCreatingQuiz == false {
            let realm = try! Realm()
            try! realm.write() {
                realm.delete((quest?.incorrect)!)
                realm.delete(quest!)
            }
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
