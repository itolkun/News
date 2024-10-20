//
//  StorageManager.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func addNews(image: String?, authorName: String?, description: String?, url: String ) -> NewsEntity? {
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "NewsEntity", in: context) else { return nil }
        
        let news = NewsEntity(entity: entity, insertInto: context)
        
        news.image = image
        news.author = authorName
        news.descript = description
        news.url = url
        news.image = image
        news.image = image
        saveContext()
        return news
    }
    
    func fetchNews(completion: @escaping ([NewsEntity]?, Error?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        do {
            let news = try context.fetch(fetchRequest)
            completion(news, nil)
        } catch {
            print("Failed to fetch news: \(error)")
            completion(nil, error)
        }
    }
    
    func deleteNewsEntity(with link: String) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", link)

        do {
            let newsEntities = try context.fetch(fetchRequest)
            for entity in newsEntities {
                context.delete(entity)
            }
            saveContext()
        } catch {
            print("Failed to delete news entity: \(error)")
        }
    }

    func fetchNewsEntity(with link: String, completion: @escaping (NewsEntity?, Error?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", link)

        do {
            let newsEntities = try context.fetch(fetchRequest)
            completion(newsEntities.first, nil)
        } catch {
            print("Failed to fetch news entity: \(error)")
            completion(nil, error)
        }
    }


    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Failed to save Core Data context: \(error)")
            }
        }
    }
}
