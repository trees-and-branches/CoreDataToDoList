//
//  ViewController.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/15/22.
//

import UIKit

class ItemsViewController: UIViewController {
    
//    init?(coder:NSCoder, toDoList: ToDoList) {
//        self.toDoList = toDoList
//        super.init(coder: coder)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    enum TableSection: Int, CaseIterable {
        case incomplete, complete
    }
    
    var toDoList: ToDoList?
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK: - Properties
    
    private let itemManager = ItemManager.shared

    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.reloadData()
    }

}


// MARK: - Private

private extension ItemsViewController {
    
    func item(at indexPath: IndexPath) -> Item? {
        if let toDoList = toDoList {
            let tableSection = TableSection(rawValue: indexPath.section)!
            switch tableSection {
            case .incomplete:
                return itemManager.incompleteItems(for: toDoList)[indexPath.row]
            case .complete:
                return itemManager.completedItems(for: toDoList)[indexPath.row]
            }
        } else {
            return nil
        }
    }
    
}
// MARK: - TableView DataSource

extension ItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableSection = TableSection(rawValue: section)!
        guard let toDoList = toDoList else { return nil }
        switch tableSection {
        case .incomplete:
            return "To-Do (\(itemManager.incompleteItems(for: toDoList).count))"
        case .complete:
            return "Completed (\(itemManager.completedItems(for: toDoList).count))"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TableSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let toDoList = toDoList {
            let tableSection = TableSection(rawValue: section)!
            switch tableSection {
            case .incomplete:
                print(itemManager.incompleteItems(for: toDoList).count)
                return itemManager.incompleteItems(for: toDoList).count
            case .complete:
                print(itemManager.completedItems(for: toDoList).count)
                return itemManager.completedItems(for: toDoList).count
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier) as! ItemTableViewCell
        if let item = item(at: indexPath) {
            cell.update(with: item)
            return cell
        } else {
            return cell
        }
    }

    
    // Swipe to Delete
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete, let toDoList = toDoList else { return }
        itemManager.delete(at: indexPath, for: toDoList)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

// MARK: - TableView Delegate

extension ItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let toDoList = toDoList, let item = item(at: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        itemManager.toggleItemCompletion(item, for: toDoList)
        tableView.reloadData()
    }
    
}


// MARK: - TextField Delegate

extension ItemsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty, let toDoList = toDoList else { return true }
        itemManager.createNewItem(with: text, in: toDoList)
        tableView.reloadSections([TableSection.incomplete.rawValue], with: .automatic)
        textField.text = ""
        return true
    }
    
}

