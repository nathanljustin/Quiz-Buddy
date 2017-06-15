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
    
    var indexChosen: Int!
    
    var quizzes: Results<Quiz>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indexChosen = 0

        let realm = try! Realm()
        quizzes = realm.objects(Quiz.self)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizTableViewCell
        
        cell.name.text = quizzes?[indexPath.row].name
        cell.number.text = "Number of Questions: \(String(describing: quizzes?[indexPath.row].questions.count))"
        cell.prevScore.text = "Previous Score: \(String(describing: quizzes?[indexPath.row].prevScore))"

        // Configure the cell...

        return cell as UITableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexChosen = indexPath.row
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
        if segue.identifier == "addSegue" {
            let navigationVC = segue.destination as! UINavigationController
            let createVC = navigationVC.topViewController as! EditQuizViewController
            createVC.isCreating = true
            createVC.quiz = Quiz()
        }
        if segue.identifier == "optionsSegue" {
            let optionsVC = segue.destination as! QuizOptionsTableViewController
            optionsVC.quiz = quizzes[indexChosen!]
        }
    }

}

class QuizTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var prevScore: UILabel!
}
