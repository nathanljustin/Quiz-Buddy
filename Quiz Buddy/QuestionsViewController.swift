//
//  QuestionsViewController.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/12/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import RealmSwift

class QuestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var quiz: Quiz? // Current quiz
    var score: Int? // Current score of user
    var order:[UInt]? // Order of questions
    var currentCorrect: UInt? // Index of current correct answer (0 = A, 1 = B, etc.)
    var currentQuestion: Int? // Current question number
    var orderOfAns: [UInt] = [] // Order of answers for the current question
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if quiz == nil {
            // Error handle not getting the quiz
            let alertController = UIAlertController(title: "Error loading quiz", message: "Please try again.", preferredStyle: .alert)
            
            // Now adding the default action to the alert controller
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        let count = quiz?.numberOfQuestions
        
        // Get random ordering of questions
        order = []
        while order?.count != count {
            let rand = arc4random_uniform(UInt32(count!))
            if !order!.contains(UInt(rand)) {
                order?.append(UInt(rand))
            }
        }
        
        // Initialize variables needed
        score = 0
        currentCorrect = 0
        currentQuestion = 0
        
        // Set initial labels
        navItem.title = "Question 1"
        questionLabel.text = quiz?.questions[Int((order?[0])!)].question
        
        // Update table
        tableView.reloadData()
        
        // Get initial order of answers
        self.getOrderOfAnswers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var answers: [String] = [] // Stores answers to current question
        
        // Put all answers into the array
        answers.append((quiz?.questions[Int((order?[currentQuestion!])!)].correct)!)
        answers.append((quiz?.questions[Int((order?[currentQuestion!])!)].incorrect[0])!.getString())
        answers.append((quiz?.questions[Int((order?[currentQuestion!])!)].incorrect[1])!.string)
        answers.append((quiz?.questions[Int((order?[currentQuestion!])!)].incorrect[2])!.string)
        
        // The first answer appended is the correct answer
        currentCorrect = UInt((orderOfAns.index(of: 0)!))
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! AnswerTableViewCell
                
        // Insert info for each line
        if indexPath.row == 0 {
            cell.letterLabel.text = "A"
            cell.answerLabel.text = answers[Int((orderOfAns[0]))]
        }
            
        else if indexPath.row == 1 {
            cell.letterLabel.text = "B"
            cell.answerLabel.text = answers[Int((orderOfAns[1]))]
        }
        
        else if indexPath.row == 2 {
            cell.letterLabel.text = "C"
            cell.answerLabel.text = answers[Int((orderOfAns[2]))]
        }
        
        else {
            cell.letterLabel.text = "D"
            cell.answerLabel.text = answers[Int((orderOfAns[3]))]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If selected the current answer, add a point
        if UInt(indexPath.row) == currentCorrect {
            score = score! + 1
        }
        
        // If it is the last question, go to score view
        if currentQuestion! + 1 == (quiz?.numberOfQuestions)! {
            performSegue(withIdentifier: "scoreSegue", sender: nil)
            return
        }
        else {
            // Update the screen for the next question
            currentQuestion = currentQuestion! + 1
            navItem.title = "Question \(currentQuestion! + 1)"
            questionLabel.text = quiz!.questions[Int((order?[currentQuestion!])!)].question
            getOrderOfAnswers()
            tableView.reloadData()
        }
    }
    
    
    @IBAction func quitAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Helper function that generates a random order of the answers for each question
    func getOrderOfAnswers() {
        orderOfAns.removeAll()
        
        while orderOfAns.count != 4 {
            let rand = arc4random_uniform(4)
            if !orderOfAns.contains(UInt(rand)) {
                orderOfAns.append(UInt(rand))
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Go to score view controller with the final score
        if segue.identifier == "scoreSegue" {
            let scoreVC = segue.destination as! ScoreViewController
            scoreVC.score = self.score!
            scoreVC.quiz = self.quiz!
        }
    }

}

class AnswerTableViewCell: UITableViewCell {
    
    //Insert IB outlets here
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var letterLabel: UILabel!
    
}
