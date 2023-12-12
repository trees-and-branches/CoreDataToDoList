//
//  ItemManager.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/21/22.
//

import Foundation
import CoreData

class ItemManager {
    static let shared = ItemManager()
    
    var allItems = [Item]()
    
    
    // Create
    
    func createNewItem(with title: String) {
        let newItem = Item(context: PersistenceController.shared.viewContext)
        newItem.id = UUID().uuidString
        newItem.title = title
        newItem.createdAt = Date()
        newItem.completedAt = nil
        allItems.append(newItem)
        PersistenceController.shared.saveContext()
    }
    // fetch?
    private func fetchItems(matching predicate: NSPredicate) -> [Item] {
        let fetchRequest = Item.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false), NSSortDescriptor(key: "completedAt", ascending: false)]
        do {
            let context = PersistenceController.shared.viewContext
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching items: \(error)")
            return []
        }
    }
    
    func fetchInCompleteItems() -> [Item] {
        return fetchItems(matching: NSPredicate(format: "completedAt == nil"))
    }
    
    func fetchCompleteItems() -> [Item] {
         
        return fetchItems(matching: NSPredicate(format: "completedAt != nil"))
        
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
      item.completedAt = item.isCompleted ? nil : Date()
      PersistenceController.shared.saveContext()
    }

    // Delete
    
    func remove(_ item: Item) {
      let context = PersistenceController.shared.viewContext
      context.delete(item)
      PersistenceController.shared.saveContext()
  }


    private func item(at indexPath: IndexPath) -> Item {
        let items = indexPath.section == 0 ? incompleteItems() : completedItems()
        return items[indexPath.row]
    }

}
