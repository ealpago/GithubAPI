//
//  MockCoreDataManager.swift
//  GithubAPITests
//
//  Created by Emre Alpago on 2.10.2024.
//

@testable import GithubAPI
import CoreData

final class MockCoreDataManager: CoreDataManagerInterface {

    var invokedContextGetter = false
    var invokedContextGetterCount = 0
    var stubbedContext: NSManagedObjectContext!

    var context: NSManagedObjectContext {
        invokedContextGetter = true
        invokedContextGetterCount += 1
        return stubbedContext
    }

    var invokedPersistentContainerGetter = false
    var invokedPersistentContainerGetterCount = 0
    var stubbedPersistentContainer: NSPersistentContainer!

    var persistentContainer: NSPersistentContainer {
        invokedPersistentContainerGetter = true
        invokedPersistentContainerGetterCount += 1
        return stubbedPersistentContainer
    }

    var invokedSaveUser = false
    var invokedSaveUserCount = 0
    var invokedSaveUserParameters: (userName: String, Void)?
    var invokedSaveUserParametersList = [(userName: String, Void)]()

    func saveUser(userName: String) {
        invokedSaveUser = true
        invokedSaveUserCount += 1
        invokedSaveUserParameters = (userName, ())
        invokedSaveUserParametersList.append((userName, ()))
    }

    var invokedFetchUniqueUserNames = false
    var invokedFetchUniqueUserNamesCount = 0
    var stubbedFetchUniqueUserNamesResult: [String]! = []

    func fetchUniqueUserNames() -> [String] {
        invokedFetchUniqueUserNames = true
        invokedFetchUniqueUserNamesCount += 1
        return stubbedFetchUniqueUserNamesResult
    }
}
