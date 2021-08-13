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

    // MARK: - Core Data Saving support

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
        let model = PhotoModel(entity: photoEntity!, insertInto: persistentContainer.viewContext)
            model.url = photo.urls.regular
            model.desc = photo.alt_description
        
            PersistentController.shared.saveContext()
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
