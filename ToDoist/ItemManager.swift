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

    
    // Create
    
    func createNewItem(with title: String) {
        let newItem = Item(title: title)
        allItems.append(newItem)
    }
    
    // Retrieve
    
    func incompleteItems() -> [Item] {
        let incomplete = allItems.filter { $0.completedAt == nil }
        return incomplete.sorted(by: { $0.sortDate >  $1.sortDate })
    }
    
    func completedItems() -> [Item] {
        let completed = allItems.filter { $0.completedAt != nil }
        return completed.sorted(by: { $0.sortDate >  $1.sortDate })
    }
    
    // Update
    
    func toggleItemCompletion(_ item: Item) {
        var updatedItem = item
        updatedItem.completedAt = item.isCompleted ? nil : Date()
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
        allItems.append(updatedItem)
    }
    
    // Delete
    
    func delete(at indexPath: IndexPath) {
        remove(item(at: indexPath))
    }
    
    func remove(_ item: Item) {
        guard let index = allItems.firstIndex(of: item) else { return }
        allItems.remove(at: index)
    }

    private func item(at indexPath: IndexPath) -> Item {
        let items = indexPath.section == 0 ? incompleteItems() : completedItems()
        return items[indexPath.row]
    }

}
