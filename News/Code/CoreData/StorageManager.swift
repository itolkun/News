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
    
    func addNews(image: String?, authorName: String?, description: String?, url: String, isFavorite: Bool ) -> NewsEntity? {
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "NewsEntity", in: context) else { return nil }
        
        let news = NewsEntity(entity: entity, insertInto: context)
        
        news.image = image
        news.author = authorName
        news.descript = description
        news.url = url
        news.image = image
        news.image = image
        news.isFavourite = isFavorite ? "1" : "0"
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
    
    func deleteNews(_ news: NewsEntity) {
        let context = persistentContainer.viewContext
        context.delete(news)
        saveContext()
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
    
    func toggleFavorite(news: NewsEntity) {
        let context = persistentContainer.viewContext
        news.isFavourite = news.isFavourite == "1" ? "0" : "1"
        saveContext()
    }
}
