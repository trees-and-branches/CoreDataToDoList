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
    
    @IBOutlet weak var tableView: UITableView!
    
    private let itemManager = ItemManager.shared
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemManager.loadMockData()
    }

}

extension ItemsViewController: ItemCellDelegate {

    func completeButtonPressed(item: Item) {
        itemManager.toggleItemCompletion(item)
        tableView.reloadSections([TableSection.incomplete.rawValue, TableSection.complete.rawValue], with: .automatic)
    }
    
}


extension ItemsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TableSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableSection = TableSection(rawValue: section)!
        switch tableSection {
        case .incomplete:
            return itemManager.items.count
        case .complete:
            return itemManager.completedItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier) as! ItemTableViewCell
        let item = item(at: indexPath)
        cell.update(with: item)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableSection = TableSection(rawValue: section)!
        switch tableSection {
        case .incomplete:
            return "To Do"
        case .complete:
            return "Completed"
        }
    }
    
    func item(at indexPath: IndexPath) -> Item {
        let tableSection = TableSection(rawValue: indexPath.section)!
        switch tableSection {
        case .incomplete:
            return itemManager.items[indexPath.row]
        case .complete:
            return itemManager.completedItems[indexPath.row]
        }
    }
    
}

extension ItemsViewController: UITableViewDelegate {
    
}
