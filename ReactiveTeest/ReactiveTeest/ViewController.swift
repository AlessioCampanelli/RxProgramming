//
//  ViewController.swift
//  ReactiveTeest
//
//  Created by Alessio Campanelli on 06/12/2018.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    
    @IBOutlet weak var rxButton: UIButton!
    @IBOutlet weak var rxSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Stuff.justTest()
        // Stuff.disposeTest()
        // Stuff.publicSubjectTest()
        // Stuff.mapTest()
        // Stuff.mapTypeTest()
        Stuff.schedulerTest()
        
        FakeDB.shared.createDatasource()
        
        let tapSub = rxButton.rx.tap.subscribe { event in
            print("tap")
        }
        
        let searchSubscribe = rxSearchBar.rx.text.subscribe { text in
            print(#line, text)
            
            let bag = DisposeBag()
            
            let searchResult = self.rxSearchBar.rx.text.orEmpty
                .throttle(0.3, scheduler: MainScheduler.instance)
                .distinctUntilChanged()
                .flatMapLatest { query -> Observable<[Person]> in
                    if query.isEmpty {
                        return .just([])
                    }
                    return Utilities.searchPeople(name: query)
                        .catchErrorJustReturn([])
                }.observeOn(MainScheduler.instance)
            
            searchResult
                .bind(to: self.tableView.rx.items(cellIdentifier: "personCell")) {
                    (index, person: Person, cell) in
                    (cell as! PersonTableViewCell).nameLabel?.text = person.name
                    (cell as! PersonTableViewCell).surnameLabel?.text = person.surname
                }
                .disposed(by: bag)
        }
        
        let editingSubscribe = rxSearchBar.rx.textDidEndEditing.subscribe { event in
            print(#line, event)
        }
        
        let itemSelSubscribe = tableView.rx.itemSelected.subscribe { event in
            print("itemSelected: \(event.element?.row ?? 0)")
        }
        
        print("editingSubscribe: ", tapSub, searchSubscribe, editingSubscribe, itemSelSubscribe)
    }
}

