//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by Олег Федоров on 30.08.2021.
//

import UIKit

class AddBirthdayViewController: UIViewController {
    
    @IBOutlet var firsNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthdayPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthdayPicker.maximumDate = Date()
    }
    
}

