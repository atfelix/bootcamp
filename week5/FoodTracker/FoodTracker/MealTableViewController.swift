//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by atfelix on 2017-06-04.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {

    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem

        if let savedMeals = loadMeals() {
            meals += savedMeals
        }
        else {
            loadSampleMeals()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        let meal = meals[indexPath.row]

        cell.nameLabel.text = meal.name
        cell.ratingControl.rating = meal.rating
        cell.photoImageView.image = meal.photo

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch (segue.identifier ?? "") {
            case "AddItemSegue": os_log("Adding new meal", log: OSLog.default, type: .debug)
            case "ShowDetailSegue":
                guard let mealDetailVC = segue.destination as? MealViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                guard let selectedMealCell = sender as? MealTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
                guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                mealDetailVC.meal = meals[indexPath.row]
            default: fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }


    // MARK: - Utility functions


    private func loadSampleMeals() {
        guard let meal1 = Meal.init(name: "Caprese Salad", photo: nil, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }

        guard let meal2 = Meal.init(name: "Chicken and potatoes", photo: nil, rating: 3) else {
            fatalError("Unable to instantiate meal2")
        }

        guard let meal3 = Meal.init(name: "Pasta with Meatballs", photo: nil, rating: 5) else {
            fatalError("Unable to instantiate meal3")
        }

        meals += [meal1, meal2, meal3]
    }

    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceVC = sender.source as? MealViewController, let meal = sourceVC.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                let newIndexPath = IndexPath(row: meals.count, section: 0)

                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveMeals()
        }
    }

    private func saveMeals() {
        if NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path) {
            os_log("Meals successfully saved", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Failed to save meals.", log: OSLog.default, type: .debug)
        }
    }

    private func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
}
