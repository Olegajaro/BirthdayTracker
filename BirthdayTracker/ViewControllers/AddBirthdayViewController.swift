//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by Олег Федоров on 30.08.2021.
//

import UIKit
import CoreData
import UserNotifications

class AddBirthdayViewController: UIViewController {
    
    @IBOutlet var firsNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthdayPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthdayPicker.maximumDate = Date()
        birthdayPicker.locale = Locale(identifier: "ru_RU")
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let firstName = firsNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let birthdate = birthdayPicker.date
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newBirthday = Birthday(context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthdate = birthdate as Date?
        newBirthday.birthdayId = UUID().uuidString
        
        if let uniqueId = newBirthday.birthdayId {
            print("birthdayId: \(uniqueId)")
        }
        
        do {
            try context.save()
            let message = "Сегодня \(firstName) \(lastName) празднует день рождения!"
            let content = UNMutableNotificationContent()
            content.body = message
            content.sound = UNNotificationSound.default
            
            var dateComponents = Calendar.current.dateComponents([.month, .day], from: birthdate)
            dateComponents.hour = 8
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            if let identifier = newBirthday.birthdayId {
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request, withCompletionHandler: nil)
            }
        } catch let error {
            print("Не удалось сохранить из-за ошибки \(error)")
        }
        
        dismiss(animated: true)
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

