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
    
}

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

