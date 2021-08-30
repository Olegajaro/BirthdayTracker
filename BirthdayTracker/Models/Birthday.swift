//
//  Birthday.swift
//  BirthdayTracker
//
//  Created by Олег Федоров on 30.08.2021.
//

class Birthday {
    let firstName: String
    let lastName: String
    let birthdate: Date
    
    init(firstName: String, lastName: String, birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
    }
}
