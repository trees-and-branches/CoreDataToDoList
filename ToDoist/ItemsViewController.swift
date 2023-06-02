//
//  ViewController.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/15/22.
//

import UIKit

class ItemsViewController: UIViewController {
    
    enum TableSection: Int, CaseIterable {
        case incomplete, complete
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK: - Properties
    
    private let itemManager = ItemManager.shared

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

}

// MARK: - Private

private extension ItemsViewController {
    
    func item(at indexPath: IndexPath) -> Item {
        let tableSection = TableSection(rawValue: indexPath.section)!
        switch tableSection {
        case .incomplete:
            return itemManager.incompleteItems()[indexPath.row]
        case .complete:
            return itemManager.completedItems()[indexPath.row]
        }
    }
    
}


// MARK: - TableView DataSource

extension ItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableSection = TableSection(rawValue: section)!
        switch tableSection {
        case .incomplete:
            return "To-Do (\(itemManager.incompleteItems().count))"
        case .complete:
            return "Completed (\(itemManager.completedItems().count))"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TableSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableSection = TableSection(rawValue: section)!
        switch tableSection {
        case .incomplete:
            return itemManager.incompleteItems().count
        case .complete:
            return itemManager.completedItems().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier) as! ItemTableViewCell
        let item = item(at: indexPath)
        cell.update(with: item)
        return cell
    }

}

extension ItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = item(at: indexPath)
        itemManager.toggleItemCompletion(item)
        tableView.reloadData()
    }
    
}


// MARK: - TextField Delegate

extension ItemsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return true }
        itemManager.createNewItem(with: text)
        tableView.reloadSections([TableSection.incomplete.rawValue], with: .automatic)
        textField.text = ""
        return true
    }
    
}
