//
//  QuizTableViewController.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/12/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import Gloss
import RealmSwift

class QuizTableViewController: UITableViewController {
    
    var indexChosen: Int! // Stores the index of the quiz chosen by the user
    var quizzes: Results<Quiz>! // Stores the quizzes from Realm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indexChosen = 0
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get all quizzes from Realm
        let realm = try! Realm()
        quizzes = realm.objects(Quiz.self)
        
        // Update table
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Int(quizzes!.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Instantiate cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizTableViewCell
        
        // Insert info into cell
        cell.name.text = quizzes?[indexPath.row].name
        
        let text1: String!
        text1 = String(describing: (quizzes?[indexPath.row].questions.count)!)
        cell.number.text = "Number of Questions: \(text1!)"

        let text2: String!
        text2 = String(describing: (quizzes?[indexPath.row].prevScore)!)
        cell.prevScore.text = "Previous Score: \(text2!)"
        
        return cell as UITableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexChosen = indexPath.row
        performSegue(withIdentifier: "optionsSegue", sender: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If choose to add a quiz
        if segue.identifier == "addSegue" {
            let navigationVC = segue.destination as! UINavigationController
            let createVC = navigationVC.topViewController as! EditQuizViewController
            createVC.isCreating = true
            createVC.quiz = Quiz()
        }
        // If choose to go to settings
        if segue.identifier == "optionsSegue" {
            let optionsVC = segue.destination as! QuizOptionsTableViewController
            optionsVC.quiz = quizzes[indexChosen!]
        }
    }

}

class QuizTableViewCell: UITableViewCell {
    // This is a class for the custom cells for each quiz
    @IBOutlet weak var name: UILabel! // name of quiz
    @IBOutlet weak var number: UILabel! // number of questions in quiz
    @IBOutlet weak var prevScore: UILabel! // previous score of quiz
}
