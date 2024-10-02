//
//  CoreDataManager.swift
//  GithubAPI
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation
import CoreData

protocol CoreDataManagerInterface {
    var context: NSManagedObjectContext { get }
    var persistentContainer: NSPersistentContainer { get }
    func saveUser(userName: String)
    func fetchUniqueUserNames() -> [String]
}

class CoreDataManager: CoreDataManagerInterface {
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GithubAPI")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveUser(userName: String) {
        let user = Users(context: context)
        user.userName = userName
        do {
            try context.save()
            print("User saved successfully!")
        } catch {
            print("Failed to save user: \(error)")
        }
    }

    func fetchUniqueUserNames() -> [String] {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Users")
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.propertiesToFetch = ["userName"]
        fetchRequest.returnsDistinctResults = true // Ensure distinct usernames
        do {
            let results = try CoreDataManager.shared.context.fetch(fetchRequest) as? [[String: Any]]
            let userNames = results?.compactMap { $0["userName"] as? String } ?? []
            return userNames.uniqued()
        } catch {
            print("Failed to fetch usernames: \(error)")
            return []
        }
    }
}
