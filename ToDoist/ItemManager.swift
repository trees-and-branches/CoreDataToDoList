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
    
//    var allItems = [Item]()
    var allToDoLists = [ToDoList]()
    
    
    // Create
    func createNewToDoList(with title: String) {
        let newToDoList = ToDoList(context: PersistenceController.shared.viewContext)
        newToDoList.id = UUID().uuidString
        newToDoList.title = title
        newToDoList.createdAt = Date()
        newToDoList.modifiedAt = nil
        allToDoLists.append(newToDoList)
        PersistenceController.shared.saveContext()
        
    }
    func createNewItem(with title: String, in toDoList: ToDoList) {
        let newItem = Item(context: PersistenceController.shared.viewContext)
        newItem.id = UUID().uuidString
        newItem.title = title
        newItem.createdAt = Date()
        newItem.completedAt = nil
        newItem.toDoList = toDoList
//        allItems.append(newItem) // will need this to append to the specific list
        PersistenceController.shared.saveContext()
    }
    // fetch?
    func fetchToDoLists(matching predicate: NSPredicate? = nil) -> [ToDoList] {
        let fetchRequest = ToDoList.fetchRequest()
//        fetchRequest.predicate = predicate // This can be nil, fetching all instances
        do {
            let context = PersistenceController.shared.viewContext
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching ToDoLists: \(error)")
            return []
        }
    }


        func items(for toDoList: ToDoList) -> [Item] {
            return (toDoList.items as? Set<Item>)?.sorted(by: { $0.sortDate < $1.sortDate }) ?? []
        }
 
    
    // Retrieve
    
    func retrieveToDoLists() -> [ToDoList] {
        return allToDoLists.sorted(by: { $0.createdAtDate > $1.createdAtDate } )
    }
    
    func incompleteItems(for toDoList: ToDoList) -> [Item] {
        let incomplete = items(for: toDoList).filter { $0.completedAt == nil }
        return incomplete.sorted(by: { $0.sortDate >  $1.sortDate })
    }
    
    func completedItems(for toDoList: ToDoList) -> [Item] {
        let completed = items(for: toDoList).filter { $0.completedAt != nil }
        return completed.sorted(by: { $0.sortDate >  $1.sortDate })
    }
    
    // Update
    func updateToDolists() { // what do I do here??
        
        
    }
    
    func toggleItemCompletion(_ item: Item, for toDoList: ToDoList) {
        var toDoList = items(for: toDoList)
        let updatedItem = item
        updatedItem.completedAt = item.isCompleted ? nil : Date()
        if let index = toDoList.firstIndex(of: item) {
            toDoList.remove(at: index)
        }
        toDoList.append(updatedItem)
    }
    
    
    // Delete
    
    func removeToDoList(_ toDoList: ToDoList) {
        guard let index = allToDoLists.firstIndex(of: toDoList) else { return }
        allToDoLists.remove(at: index)
    }
    
    func delete(at indexPath: IndexPath, for toDoList: ToDoList) {
        remove(item(at: indexPath, for: toDoList), for: toDoList)
    }
    
    func remove(_ item: Item, for toDoList: ToDoList) {
        var items = items(for: toDoList)
        guard let index = items.firstIndex(of: item) else { return }
        items.remove(at: index)
    }

    private func item(at indexPath: IndexPath, for toDoList: ToDoList) -> Item {
        
        let items = indexPath.section == 0 ? completedItems(for: toDoList) : incompleteItems(for: toDoList) // put complete and incomplete items here
        return items[indexPath.row]
    }

}
//    private func fetchItems(matching predicate: NSPredicate) -> [Item] {
//        let fetchRequest = Item.fetchRequest()
//        fetchRequest.predicate = predicate
//        do {
//            let context = PersistenceController.shared.viewContext
//            return try context.fetch(fetchRequest)
//        } catch {
//            print("Error fetching items: \(error)")
//            return []
//        }
//    }
//
//    func fetchIncompleteItems() -> [Item] {
//
//        return .itemsArray.filter { $0.completedAt != nil }
//
//    func fetchCompleteItems() -> [Item] {
//        return fetchItems(matching: NSPredicate(format: "completedAt != nil"))
//    }
