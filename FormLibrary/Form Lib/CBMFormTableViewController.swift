//
//  CBMFormTableViewController.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/25/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

/// Unique form implemntations should inherit from this class
open class CBMFormTableViewController: UITableViewController {
    
    // MARK: Properties
    open var sections: [CBMFormSectionAttributes] = []
    
    // MARK: Init
    convenience init(sections: [CBMFormSectionAttributes]) {
        self.init(style: .grouped)
        self.sections = sections
    }
    
}

// MARK: UITableViewDataSource
extension CBMFormTableViewController {
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellAttributes = fetchCellAttributes(at: indexPath)
        guard let rootCellClass = fetchCellClass(from: cellAttributes) else { return UITableViewCell() }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: rootCellClass)) as? CBMFormRootCell
        
        if cell == nil {
            cell = rootCellClass.init(style: .default, reuseIdentifier: String(describing: rootCellClass))
            cell?.formViewController = self
            cell?.configure()
        }
        
        cell?.cellAttributes = cellAttributes
        
        return cell ?? UITableViewCell()
    }

}

// MARK: UITableViewDelegate
extension CBMFormTableViewController {
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellAttributes = fetchCellAttributes(at: indexPath)
        
        if let selectedRow = tableView.cellForRow(at: indexPath) as? CBMFormRootCell {
            if let formBaseCellClass = fetchCellClass(from: cellAttributes) {
                formBaseCellClass.formViewController(self, didSelectRow: selectedRow)
            }
        }
        
        cellAttributes.didSelectClosure?(cellAttributes)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = sections[section].headerAttributes?.view else { return nil }
        headerView.cellAttributes = sections[section].headerAttributes
        return headerView
    }
    
    open override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = sections[section].footerAttributes?.view else { return nil }
        footerView.cellAttributes = sections[section].footerAttributes
        return footerView
    }
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    open override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

// MARK: Private Methods
extension CBMFormTableViewController {
    
    private func fetchCellAttributes(at indexPath: IndexPath) -> CBMFormCellAttributes {
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    private func fetchCellClass(from cellAttributes: CBMFormCellAttributes) -> CBMFormRootCell.Type? {
        guard let cellClass = cellAttributes.cellClass as? CBMFormRootCell.Type else { return nil }
        return cellClass
    }
    
}
