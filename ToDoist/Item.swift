//
//  Item.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/21/22.
//

import Foundation

struct Item: Identifiable {
    let id: String
    let title: String
    let createdAt: Date
    var completedAt: Date?
    
    var isCompleted: Bool {
        completedAt != nil
    }
    var subtitle: String {
        if isCompleted, let completedAtString {
            return completedAtString
        }
        return createdAtString
    }
    var sortDate: Date {
        if isCompleted, let completedAt {
            return completedAt
        }
        return createdAt
    }
    
}

extension Item: Equatable {
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.createdAt == rhs.createdAt &&
        lhs.completedAt == rhs.completedAt
    }
    
}

extension Item: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}


extension Item {
    
    static var relativeDateFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .abbreviated
        formatter.formattingContext = .beginningOfSentence
        return formatter
    }()

    var createdAtString: String {
        Item.relativeDateFormatter.localizedString(for: createdAt, relativeTo: Date())
    }
    
    var completedAtString: String? {
        guard let completedAt else { return nil }
        return Item.relativeDateFormatter.localizedString(for: completedAt, relativeTo: Date())
    }
    
}
