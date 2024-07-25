//
//  CoreDataManager.swift
//  MovieReservation_4Team
//
//  Created by ahnzihyeon on 7/23/24.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager() // 싱글톤 인스턴스 사용
    
    private init() {} // private initializer 설정

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieReservation_4Team") // Core Data 모델 이름
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveUser(name: String, phone: String, id: String, password: String, userprofile: Data?) {
        let user = Movieuserdata(context: context)
        user.name = name
        user.phone = phone
        user.id = id
        user.password = password
        user.userprofile = userprofile
        
        do {
            try context.save()
        } catch {
            print("Failed to save user: \(error)")
        }
    }

    func updateUser(id: String, name: String?, phone: String?, password: String?, userprofile: Data?) {
        let fetchRequest: NSFetchRequest<Movieuserdata> = Movieuserdata.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let user = results.first {
                if let name = name {
                    user.name = name
                }
                if let phone = phone {
                    user.phone = phone
                }
                if let password = password {
                    user.password = password
                }
                if let userprofile = userprofile {
                    user.userprofile = userprofile
                }
                
                try context.save()
            } else {
                print("User with id \(id) not found")
            }
        } catch {
            print("Failed to update user: \(error)")
        }
    }

    func fetchUser(byId id: String) -> Movieuserdata? {
        let fetchRequest: NSFetchRequest<Movieuserdata> = Movieuserdata.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch user: \(error)")
            return nil
        }
    }
}
