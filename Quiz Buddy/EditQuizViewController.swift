//
//  QuestionsViewController.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/12/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import Realm

class EditQuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var isCreating: Bool?
    var quiz: Quiz?
    var index: UInt?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "questionCell")
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        if isCreating == false {
            nameText.text = quiz?.name
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isCreating == true {
            navItem.title = "Create Quiz"
        }
        else {
            navItem.title = "Edit Quiz"
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Int((quiz?.questions.count)!)
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) 
        
        // Insert info
        let quest = quiz?.questions.object(at: UInt(indexPath.row)) as! Question
        cell.textLabel?.text = quest.question
        cell.detailTextLabel?.text = "Answer: \(quest.correct)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = UInt(indexPath.row)
        performSegue(withIdentifier: "editQuestionSegue", sender: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        quiz?.name = nameText.text!
        
        if isCreating == true {
            let realm = RLMRealm.default()
            realm.beginWriteTransaction()
            realm.add(quiz!)
            print("Realm URL: \(realm.configuration.fileURL!.absoluteString)")
            do {
                try realm.commitWriteTransactionWithoutNotifying([])
            } catch {
                print("Error")
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addQuestionSegue" {
            let navVC = segue.destination as! UINavigationController
            let editQuestionVC = navVC.topViewController as! EditQuestionViewController
            editQuestionVC.quest = Question()
            editQuestionVC.quiz = self.quiz!
            editQuestionVC.isCreating = true
        }
        if segue.identifier == "editQuestionSegue" {
            let navVC = segue.destination as! UINavigationController
            let editQuestionVC = navVC.topViewController as! EditQuestionViewController
            editQuestionVC.quest = quiz?.questions.object(at: index!) as? Question
            editQuestionVC.quiz = self.quiz!
            editQuestionVC.isCreating = false

        }
     }
    
    
}
