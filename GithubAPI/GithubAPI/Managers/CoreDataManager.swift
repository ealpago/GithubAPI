//
//  CoreDataManager.swift
//  GithubAPI
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

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

    func fetchUsers() -> [Users] {
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch users: \(error)")
            return []
        }
    }
}
