//
//  Helper.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import Foundation

func formatDate(_ dateString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    if let date = dateFormatter.date(from: dateString) {
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd.MM.yyyy"
        
        return displayFormatter.string(from: date)
    }
    
    return nil
}
