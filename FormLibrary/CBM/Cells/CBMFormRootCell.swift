//
//  CBMFormRootCell.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/25/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

open class CBMFormRootCell: UITableViewCell {
    
    // MARK: Properties
    open var cellAttributes: CBMFormCellAttributes? {
        didSet {
            self.update()
        }
    }
    
    open weak var formViewController: CBMFormTableViewController?
    
    // MARK: Init
    public required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Public interface
    open func configure() {
        /// override
    }
    
    open func update() {
        /// override
    }
    
    open class func formRowCellHeight() -> CGFloat {
        return 44.0
    }

}



