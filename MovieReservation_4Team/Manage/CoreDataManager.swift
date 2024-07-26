//
//  CoreDataManager.swift
//  MovieReservation_4Team
//
//  Created by ahnzihyeon on 7/23/24.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieUserData") // 모델 파일의 이름과 일치해야 함
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveUser(name: String, phone: String, id: String, password: String, userprofile: Data?) {
        let user = UserData(context: context)
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
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
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
    
    // id에 해당하는 사용자를 Core Data 데이터베이스에서 가져오는 역할
    func fetchUser(byId id: String) -> UserData? {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch user: \(error)")
            return nil
        }
    }

    // id와 password가 Core Data에 저장된 사용자 데이터와 일치하는지 확인
    func validateUser(id: String, password: String) -> Bool {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@ AND password == %@", id, password)
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Failed to validate user: \(error)")
            return false
        }
    }
    
    func deleteUser(byId id: String) {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let user = results.first {
                context.delete(user)
                try context.save()
            } else {
                print("User with id \(id) not found")
            }
        } catch {
            print("Failed to delete user: \(error)")
        }
    }
}
