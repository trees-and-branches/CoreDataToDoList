//
//  ItemManager.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/21/22.
//

import Foundation

class ItemManager {
    static let shared = ItemManager()
    
    var allItems = Set<Item>() {
        didSet {
            items = allItems.filter { $0.completedAt == nil }.sorted(by: { $0.createdAt >  $1.createdAt })
            completedItems =
            allItems.filter { $0.completedAt != nil }.sorted(by: { $0.createdAt >  $1.createdAt })
        }
    }
    var items = [Item]()
    var completedItems = [Item]()

    
    // Funcs
    
    func add(_ item: Item) {
        allItems.update(with: item)
    }
    
    func toggleItemCompletion(_ item: Item) {
        var updatedItem = item
        updatedItem.completedAt = item.isCompleted ? nil : Date()
        allItems.update(with: updatedItem)
    }
    
    func remove(_ item: Item) {
        guard allItems.contains(item) else { return }
        allItems.remove(item)
    }
    
    // Mock Data
    
    func loadMockData() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        let tenMinutesAgo = Calendar.current.date(byAdding: .minute, value: -10, to: Date())!
        let mock1 = Item(id: UUID().uuidString, title: "Make my bed", createdAt: Date(), completedAt: nil)
        let mock2 = Item(id: UUID().uuidString, title: "Take out the trash", createdAt: twoDaysAgo, completedAt: nil)
        let mock3 = Item(id: UUID().uuidString, title: "Buy that thing", createdAt: twoDaysAgo, completedAt: yesterday)
        let mock4 = Item(id: UUID().uuidString, title: "Finish homework", createdAt: yesterday, completedAt: Date())
        allItems = [mock1, mock2, mock3, mock4]
    }

}
