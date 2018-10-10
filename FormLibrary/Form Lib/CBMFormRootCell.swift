//
//  CBMFormRootCell.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/25/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

/// All custom cells for tableview forms should inheret from this root class
open class CBMFormRootCell: UITableViewCell {
    
    // MARK: Properties
    open var cellAttributes: CBMFormCellAttributes? {
        didSet {
            self.update()
        }
    }
    
    open weak var formViewController: CBMFormTableViewController?
    
    // MARK: Initalization
    public required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Public interface
    open class func formViewController(_ formViewController: CBMFormTableViewController, didSelectRow: CBMFormRootCell) {
    }
    
    /// Called once upon cell initalization
    /// Used to setup inital autolayout constraints
    open func configure() {
        /// Should override
    }
    
    /// Called every time cellForRowAt is called
    /// Used for data binding and dynamic configuration
    open func update() {
        /// Should override
    }

}

open class CBMFormRootHeaderFooterView: UIView {
    
    open weak var cellAttributes: CBMFormHeaderFooterAttributes? {
        didSet {
            self.update()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    deinit {
        print("CBMFormRootHeaderFooterView deinit")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// Called every time cellForRowAt is called
    /// Used for data binding and dynamic configuration
    open func update() {
        /// Should override
    }
    
}




