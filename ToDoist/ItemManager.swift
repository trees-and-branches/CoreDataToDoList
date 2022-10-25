//
//  ItemManager.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/21/22.
//

import Foundation

class ItemManager {
    static let shared = ItemManager()
    
    var allItems = [Item]()
    var items: [Item] {
        allItems.filter { $0.completedAt == nil }.sorted(by: { $0.sortDate >  $1.sortDate })
    }
    var completedItems: [Item] {
        allItems.filter { $0.completedAt != nil }.sorted(by: { $0.sortDate >  $1.sortDate })
    }

    
    // Funcs
    
    func createNewItem(with title: String) {
        let newItem = Item(title: title)
        allItems.append(newItem)
    }
    
    func toggleItemCompletion(_ item: Item) {
        var updatedItem = item
        updatedItem.completedAt = item.isCompleted ? nil : Date()
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
        allItems.append(updatedItem)
    }
    
    func remove(_ item: Item) {
        guard let index = allItems.firstIndex(of: item) else { return }
        allItems.remove(at: index)
    }

}
