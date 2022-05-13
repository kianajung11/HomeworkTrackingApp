//
//  Persistence.swift
//  Final
//
//  Created by Kiana Jung on 4/26/22.
//  This is the persistent controller for core date

import Foundation
import CoreData

struct PersistentController{
    static let shared = PersistentController() // Singleton controlled
let container: NSPersistentContainer
    init(){ //initializer the .xcdatamodel
        container = NSPersistentContainer(name: "Assignments") //Provide the name of the model
        container.loadPersistentStores(completionHandler: //Check if there is errors loading data
                                       {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error:\(error)")
            }
        })
    }
}
