//
//  QuizOptionsTableViewController.swift
//  Quiz Buddy
//
//  Created by Nathan Justin on 6/12/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import RealmSwift

class QuizOptionsTableViewController: UITableViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    var quiz: Quiz?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Set title of screen as quiz name
        navBar.title = quiz?.name
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
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If delete is pressed
        if indexPath.row == 2 {
            
            // Alert the user that this is an irreversible action
            let alertController = UIAlertController(title: "Delete this Quiz?", message: "This action cannot be undone", preferredStyle: .alert)
            
            // Now adding the default action to the alert controller
            alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: yesDelete))
            alertController.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)

            return
        }
    }
    
    // Delete the current quiz from Realm
    func yesDelete(action: UIAlertAction) {
        let realm = try! Realm()
        try! realm.write() {
            // Must delete all layers to save space in memory for user
            // Delete incorrect answers
            for quest in (quiz?.questions)! {
                realm.delete(quest.incorrect)
            }
            
            // Delete questions
            realm.delete((quiz?.questions)!)
            
            // Delete quiz
            realm.delete(quiz!)
        }
        self.navigationController?.popViewController(animated: true)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        // If chooses to edit the quiz
        if segue.identifier == "editQuizSegue" {
            let navVC = segue.destination as! UINavigationController
            let editVC = navVC.topViewController as! EditQuizViewController
            editVC.isCreating = false
            editVC.quiz = self.quiz
        }
        // If chooses to start quiz
        if segue.identifier == "startSegue" {
            let navVC = segue.destination as! UINavigationController
            let questVC = navVC.topViewController as! QuestionsViewController
            questVC.quiz = self.quiz
        }
    }
    
    
}
