//
//  Utilities.swift
//  ReactiveTeest
//
//  Created by Alessio Campanelli on 07/12/2018.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import Foundation
import RxSwift

struct Utilities {
    
    static func searchPeople(name: String) -> Observable<[Person]> {
        return Observable.create { observer in
            
            let result = FakeDB.shared.persons.filter {
                $0.name.contains(name)
            }
            observer.on(.next(result))
            observer.on(.completed)
            return Disposables.create()
        }
    }
}
