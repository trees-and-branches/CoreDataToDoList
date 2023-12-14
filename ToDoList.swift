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
    var completedAtString: String? {
        guard let completedAt else { return nil }
        return Item.relativeDateFormatter.localizedString(for: completedAt, relativeTo: Date())
    }
    
}

// MARK: - Date Formatter

extension Item {
    
    static var relativeDateFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .abbreviated
        formatter.formattingContext = .beginningOfSentence
        return formatter
    }()

}

