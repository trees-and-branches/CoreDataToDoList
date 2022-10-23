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
    
    // Mock Data
    
    func loadMockData() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        let tenMinutesAgo = Calendar.current.date(byAdding: .minute, value: -10, to: Date())!
        let mock1 = Item(id: UUID().uuidString, title: "Make my bed", createdAt: Date(), completedAt: nil)
        let mock2 = Item(id: UUID().uuidString, title: "Take out the trash", createdAt: twoDaysAgo, completedAt: nil)
        let mock3 = Item(id: UUID().uuidString, title: "Buy that thing", createdAt: twoDaysAgo, completedAt: yesterday)
        let mock4 = Item(id: UUID().uuidString, title: "Finish homework", createdAt: yesterday, completedAt: tenMinutesAgo)
        allItems = [mock1, mock2, mock3, mock4]
    }

}
