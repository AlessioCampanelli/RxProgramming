//
//  FakeDB.swift
//  ReactiveTeest
//
//  Created by Alessio Campanelli on 07/12/2018.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import Foundation

class FakeDB {
    
    static let shared = FakeDB()
    
    var persons: [Person]
    
    init() {
        persons = [Person]()
    }
    
    func createDatasource() {
        persons.append(Person(name: "Mark", surname: "Red"))
        persons.append(Person(name: "Matt", surname: "Grey"))
        persons.append(Person(name: "Mirk", surname: "Violet"))
        persons.append(Person(name: "Anne", surname: "Green"))
        persons.append(Person(name: "Alex", surname: "Green"))
        persons.append(Person(name: "Andrew", surname: "Black"))
        persons.append(Person(name: "John", surname: "Orange"))
    }
}
