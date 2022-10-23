//
//  ItemDataSource.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/22/22.
//

import UIKit

class ItemDataSource: UITableViewDiffableDataSource<ItemsViewController.TableSection, Item> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableSection = ItemsViewController.TableSection(rawValue: section)!
        switch tableSection {
        case .incomplete:
            return "To Do"
        case .complete:
            return "Completed"
        }
    }
    
}
