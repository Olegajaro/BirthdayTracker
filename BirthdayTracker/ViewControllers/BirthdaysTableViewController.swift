//
//  BirthdaysTableViewController.swift
//  BirthdayTracker
//
//  Created by Олег Федоров on 01.09.2021.
//

import UIKit

class BirthdaysTableViewController: UITableViewController, AddBirthdayViewControllerDelegate {
    
    var birthdays = [Birthday]()
    
    let dateFormatter = DateFormatter()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        birthdays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthdayCellIdentifier", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let birthday = birthdays[indexPath.row]
        
        content.text = birthday.fullName
        content.secondaryText = dateFormatter.string(from: birthday.birthdate)
        
        cell.contentConfiguration = content
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController =
                segue.destination as? UINavigationController else { return }
        guard let addBirthdayViewController =
                navigationController.topViewController as? AddBirthdayViewController else { return }
        
        addBirthdayViewController.delegate = self
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - AddBirthdayViewControllerDelegate
    func addBirthdayViewController(_ addBirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday) {
        birthdays.append(birthday)
        tableView.reloadData()
    }
}
