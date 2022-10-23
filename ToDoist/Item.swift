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
    
}

extension Item: Equatable {
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
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
        formatter.dateTimeStyle = .numeric
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
