//
//  BirthdaysTableViewController.swift
//  BirthdayTracker
//
//  Created by Олег Федоров on 01.09.2021.
//

import UIKit
import CoreData
import UserNotifications

class BirthdaysTableViewController: UITableViewController {
    
    var birthdays = [Birthday]()
    
    let dateFormatter = DateFormatter()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = Birthday.fetchRequest() as NSFetchRequest<Birthday>
        
        let sortDescriptorOne = NSSortDescriptor(key: "lastName", ascending: true)
        let sortDescriptorTwo = NSSortDescriptor(key: "firstName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptorOne, sortDescriptorTwo]
        
        do {
            birthdays = try context.fetch(fetchRequest)
        } catch let error {
            print("Не удалось загрузить данные из-за ошибки: \(error).")
        }
        tableView.reloadData()
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
        
        let firstName = birthday.firstName ?? ""
        let lastName = birthday.lastName ?? ""
        content.text = firstName + " " + lastName
        
        if let date = birthday.birthdate as Date? {
            content.secondaryText = dateFormatter.string(from: date)
        } else {
            content.secondaryText = " "
        }
        
        cell.contentConfiguration = content
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if birthdays.count > indexPath.row {
            let birthday = birthdays[indexPath.row]
            if let identifier = birthday.birthdayId {
                let center = UNUserNotificationCenter.current()
                center.removePendingNotificationRequests(withIdentifiers: [identifier])
            }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(birthday)
            birthdays.remove(at: indexPath.row)
            
            do {
                try context.save()
            } catch let error {
                print("Не удалось сохранить из-за ошибки \(error).")
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
