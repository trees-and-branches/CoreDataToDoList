//
//  ViewController.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/15/22.
//

import UIKit

class ItemsViewController: UIViewController {
    
    enum TableSection: Int {
        case incomplete, complete
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private let itemManager = ItemManager.shared
    
    private lazy var datasource: ItemDataSource = {
        let datasource = ItemDataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier) as! ItemTableViewCell
            cell.update(with: item)
            cell.delegate = self
            return cell
        }
        return datasource
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = datasource
        itemManager.loadMockData()
        generateNewSnapshot()
    }

}

extension ItemsViewController: ItemCellDelegate {

    func completeButtonPressed(item: Item) {
        itemManager.toggleItemCompletion(item)
        generateNewSnapshot(updatedItem: item)
    }
    
}


private extension ItemsViewController {
    
    func generateNewSnapshot(updatedItem: Item? = nil) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Item>()
        snapshot.appendSections([.incomplete])
        snapshot.appendItems(itemManager.items, toSection: .incomplete)
        
        if !itemManager.completedItems.isEmpty {
            snapshot.appendSections([.complete])
            snapshot.appendItems(itemManager.completedItems, toSection: .complete)
        }
        DispatchQueue.main.async {
            self.datasource.apply(snapshot)
        }
    }
    
}
