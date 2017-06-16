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
    
    var quiz: Quiz?
    var score: Int?
    var order:[UInt]?
    var currentCorrect: UInt?
    var currentQuestion: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if quiz == nil {
            print("Error getting quiz")
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
        
        score = 0
        currentCorrect = 0
        currentQuestion = 0
        
        navItem.title = "Question 1"
        
        tableView.reloadData()
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
        
        // Get ordering of answers
        var temp:[UInt] = []
        while temp.count != 4 {
            let rand = arc4random_uniform(4)
            if !temp.contains(UInt(rand)) {
                temp.append(UInt(rand))
            }
        }
        
        // Get answers
        let question = quiz?.questions[Int((order?[currentQuestion!])!)]
        let correctAnswer = RLMString()
        correctAnswer.setString(string: (quiz?.questions[Int((order?[currentQuestion!])!)].correct)!)
        
        var answers: [RLMString] = []
        
        let inc = quiz?.questions[Int((order?[currentQuestion!])!)].incorrect
        print(inc)
        
        answers.append(correctAnswer)
        answers.append((quiz?.questions[Int((order?[currentQuestion!])!)].incorrect[0])!)
        answers.append((quiz?.questions[Int((order?[currentQuestion!])!)].incorrect[1])!)
        answers.append((quiz?.questions[Int((order?[currentQuestion!])!)].incorrect[2])!)
        
        currentCorrect = UInt(temp.index(of: 0)!)
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! AnswerTableViewCell
                
        // Insert info
        if indexPath.row == 0 {
            cell.letterLabel.text = "A"
            cell.answerLabel.text = answers[Int(temp[0])].getString()
        }
        
        else if indexPath.row == 1 {
            cell.letterLabel.text = "B"
            cell.answerLabel.text = answers[Int(temp[1])].getString()
        }
        
        else if indexPath.row == 2 {
            cell.letterLabel.text = "C"
            cell.answerLabel.text = answers[Int(temp[2])].getString()
        }
        
        else {
            cell.letterLabel.text = "D"
            cell.answerLabel.text = answers[Int(temp[3])].getString()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UInt(indexPath.row) == currentCorrect {
            score = score! + 1
        }
        
        if currentQuestion! + 1 == (quiz?.numberOfQuestions)! {
            performSegue(withIdentifier: "scoreSegue", sender: nil)
            return
        }
        else {
            currentQuestion = currentQuestion! + 1
            navItem.title = "Question \(currentQuestion! + 1)"
            tableView.reloadData()
        }
    }
    
    
    @IBAction func quitAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
