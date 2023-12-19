//
//  ToDoList.swift
//  ToDoist
//
//  Created by shark boy on 12/13/23.
//

import Foundation



extension ToDoList {
    
    // Computed
    
    var createdAtDate: Date {
        createdAt ?? Date.distantPast
    }
    
    
    var createdAtString: String {
        Item.relativeDateFormatter.localizedString(for: createdAtDate, relativeTo: Date())
    }
    
        var itemsArray: [Item] {
            // Assuming 'items' is the Core Data relationship
            // Sort and filter as needed
            let sortedItems = (items as? Set<Item>)?.sorted { $0.sortDate < $1.sortDate }
            return sortedItems ?? []
        }

    
    
}
//
//extension ToDoList {
//    
//    func completedItems() -> [Item] {
//        return itemsArray.filter { $0.completedAt != nil }
//                    .sorted(by: { $0.sortDate < $1.sortDate })
//    }
//
//    func incompleteItems() -> [Item] {
//        return itemsArray.filter { $0.completedAt == nil }
//                    .sorted(by: { $0.sortDate < $1.sortDate })
//    }
//}

// MARK: - Date Formatter

extension ToDoList {
    
    static var relativeDateFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .abbreviated
        formatter.formattingContext = .beginningOfSentence
        return formatter
    }()

}

