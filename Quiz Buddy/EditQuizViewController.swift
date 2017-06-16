//
//  QuestionsViewController.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/12/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import RealmSwift

class EditQuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // This class is used for both creating and editing a quiz
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var navItem: UINavigationItem!
    
    
    var isCreating: Bool? // true if creating, not editing, a quiz
    var quiz: Quiz? // current Quiz
    var index: Int? // holds the index of a selected question
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "questionCell")
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Title the view controller appropriately
        if isCreating == true {
            navItem.title = "Create Quiz"
        }
        else {
            navItem.title = "Edit Quiz"
            // When editing, title the quiz the quiz name
            nameText.text = quiz?.name
        }
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int((quiz?.questions.count)!)
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Use the question cell
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) 
        
        // Insert info
        let quest = quiz?.questions[indexPath.row]
        cell.textLabel?.text = quest?.question
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If a question is selected, can edit question
        index = indexPath.row
        performSegue(withIdentifier: "editQuestionSegue", sender: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        let realm = try! Realm()
        
        // Do different realm writes based on whether we are creating or editing a quiz
        if isCreating == true {
            quiz?.name = nameText.text!
            quiz?.numberOfQuestions = (quiz?.questions.count)!
            try! realm.write {
                realm.add(quiz!)
                print("Path to realm file: " + realm.configuration.fileURL!.absoluteString)
            }
        }
        else {
            try! realm.write {
                quiz?.name = nameText.text!
                quiz?.numberOfQuestions = (quiz?.questions.count)!
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Adding a question
        if segue.identifier == "addQuestionSegue" {
            let navVC = segue.destination as! UINavigationController
            let editQuestionVC = navVC.topViewController as! EditQuestionViewController
            editQuestionVC.quest = Question()
            editQuestionVC.quiz = self.quiz!
            editQuestionVC.isCreatingQuest = true
            editQuestionVC.isCreatingQuiz = isCreating
        }
        
        //Editing a question
        if segue.identifier == "editQuestionSegue" {
            let navVC = segue.destination as! UINavigationController
            let editQuestionVC = navVC.topViewController as! EditQuestionViewController
            editQuestionVC.quest = quiz?.questions[index!]
            editQuestionVC.quiz = self.quiz!
            editQuestionVC.isCreatingQuest = false
            editQuestionVC.isCreatingQuiz = isCreating
        }
     }
    
    
}
