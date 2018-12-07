//
//  Stuff.swift
//  ReactiveTeest
//
//  Created by Alessio Campanelli on 07/12/2018.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import Foundation
import RxSwift

class Stuff {
    
    static func disposeTest() {
        
        let bag = DisposeBag()
        
        let observable = Observable.just("Hello Rx Disposte!")
        
        // Creating a subscription just for next events
        let subscription = observable.subscribe (onNext:{
            print($0)
        })
        
        // Adding the Subscription to a Dispose Bag
        subscription.disposed(by: bag)
    }
    
    static func publicSubjectTest() {
        let bag = DisposeBag()
        let publishSubject = PublishSubject<String>()
        
        publishSubject.onNext("Hello")
        publishSubject.onNext("Word")
        
        /*enum StringError: Error {
         case tooLong
         }
         publishSubject.onError(StringError.tooLong)*/
        
        let subscription1 = publishSubject.subscribe(onNext:{
            print($0)
        })
        subscription1.disposed(by: bag)
        
        // Subscription1 receives these 2 events, Subscription2 won't
        publishSubject.onNext("Hello")
        publishSubject.onNext("Again")
        
        // Sub2 will not get "Hello" and "Again" because it susbcribed later
        let subscription2 = publishSubject.subscribe(onNext:{
            print(#line,$0)
        }, onError: {
            print(#line,$0)
        })
        publishSubject.onNext("Both Subscriptions receive this message")
        
        print("subscription1: ", subscription1)
        print("subscription2: ", subscription2)
    }
    
    static func mapTest() {
        
        let observ = Observable<Int>.of(1,2,3,4,5,6,7,8,9,10).map { value in
            return value * 10
            }.subscribe(onNext:{
                print(#line,$0)
            }, onError: {
                print(#line,$0)
            })
        
        print("observ: ", observ)
    }
    
    static func mapTypeTest() {
        let pers1 = Person(name: "Ale", surname: "Test1")
        let pers2 = Person(name: "Fla", surname: "Test2")
        
        let observ = Observable<Person>.of(pers1, pers2).map { value in
            return value.name + " ciao"
            }.subscribe(onNext: {
                print(#line, $0)
            })
        
        print("observ: ", observ)
    }
    
    static func schedulerTest() {
        
        let publish1 = PublishSubject<Int>()
        let publish2 = PublishSubject<Int>()
        let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        
        let observ = Observable.of(publish1,publish2)
            .observeOn(concurrentScheduler)
            .merge()
            .subscribeOn(MainScheduler())
            .subscribe(onNext:{
                print($0)
            })
        publish1.onNext(20)
        publish1.onNext(40)
        
        print("observ: ", observ)
    }
    
    static func justTest() {
        
        //let helloSequence = Observable.just("Hello Rx")
        let helloSequence = Observable.from(["H", "E", "L", "L", "O"])
        
        let subscription = helloSequence.subscribe { event in
            print("rx: ", event)
            
            switch event {
            case .next(let value):
                print(value)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        
        print("subscription: ", subscription)
    }
}
