//
//  ItemDataSource.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/22/22.
//

import UIKit

protocol ItemDelegate {
    func shouldReload()
}

class ItemDataSource: UITableViewDiffableDataSource<ItemsViewController.TableSection, Item> {
    
    var delegate: ItemDelegate?
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableSection = ItemsViewController.TableSection(rawValue: section)!
        switch tableSection {
        case .incomplete:
            return "To Do"
        case .complete:
            return "Completed"
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        ItemManager.shared.delete(at: indexPath)
        delegate?.shouldReload()
    }
    
}
