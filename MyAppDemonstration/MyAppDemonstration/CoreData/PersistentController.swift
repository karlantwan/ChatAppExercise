//
//  PersistentController.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/13/21.
//

import CoreData

class PersistentController {
    static let shared = PersistentController()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PhotoGallery")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        print(container.persistentStoreDescriptions.first?.url as Any)
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func insertData(_ photo: Photos) {
        
        let photoEntity = NSEntityDescription.entity(forEntityName: "PhotoModel", in: persistentContainer.viewContext)
        let photoModel = PhotoModel(entity: photoEntity!, insertInto: persistentContainer.viewContext)
            photoModel.url = photo.urls.regular
            photoModel.desc = photo.alt_description
        
        let userEntity = NSEntityDescription.entity(forEntityName: "UserModel", in: persistentContainer.viewContext)
        let userModel = UserModel(entity: userEntity!, insertInto: persistentContainer.viewContext)
            userModel.name = photo.user.name
            userModel.profileImage = photo.user.profileImage.medium
        
        photoModel.user = userModel
        userModel.photo = photoModel
        
        saveContext()
        }
    
    func truncate(tableName: String){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: tableName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            _ = try persistentContainer.viewContext.execute(deleteRequest)
        }catch {
            fatalError("Failed to execute request: \(error)")
        }
    }
    }

let db = PersistentController.shared
