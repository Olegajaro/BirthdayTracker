//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by Олег Федоров on 30.08.2021.
//

import UIKit

protocol AddBirthdayViewControllerDelegate {
    func addBirthdayViewController(
        _ addBirthdayViewController: AddBirthdayViewController,
        didAddBirthday birthday: Birthday
    )
}

class AddBirthdayViewController: UIViewController {
    
    @IBOutlet var firsNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthdayPicker: UIDatePicker!
    
    var delegate: AddBirthdayViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthdayPicker.maximumDate = Date()
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let firstName = firsNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        
        let birthday = birthdayPicker.date
        
        let newBirthday = Birthday(firstName: firstName, lastName: lastName, birthdate: birthday)
        
        delegate?.addBirthdayViewController(self, didAddBirthday: newBirthday)
//        print("Создана запись о дне рождения")
//        print("Имя: \(newBirthday.firstName)")
//        print("Фамилия: \(newBirthday.lastName)")
//        print("День Рождения: \(newBirthday.birthdate)")
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

