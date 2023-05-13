//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Adam on 13/05/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    //MARK: - Properties
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
/*===================================================*/
    //MARK: - Init
    private init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                fatalError("Unable to initialize core data stack \(error), \(error.userInfo)")
            }
        }
    }
    
/*==================================================*/
    //MARK: - Core data Functions
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func fetchArticles() -> [ArticlesEntity] {
        do {
            return try viewContext.fetch(ArticlesEntity.fetchRequest())
        } catch {
            print("Failed to fetch data from core data! with error: \(error)")
            return []
        }
    }
}
