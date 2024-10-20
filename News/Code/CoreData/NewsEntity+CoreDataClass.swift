//
//  NewsEntity+CoreDataClass.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//
//

import Foundation
import CoreData

@objc(NewsEntity)
public class NewsEntity: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var image: String?
    @NSManaged public var descript: String?
    @NSManaged public var url: String?
    @NSManaged public var date: String?
}
extension NewsEntity : Identifiable {}
