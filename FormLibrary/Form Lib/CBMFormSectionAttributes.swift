//
//  CBMFormSectionAttributes.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/25/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

/// Defines sections of a tableview
public final class CBMFormSectionAttributes {
    
    // MARK: Properties
    public var rows: [CBMFormCellAttributes] = []
    public var headerTitle: String?
    public var footerTitle: String?
    public var headerView: UIView?
    public var footerView: UIView?
    
    // MARK: Initialization
    public init(headerTitle: String? = nil,
                footerTitle: String? = nil,
                headerView: UIView? = nil,
                footerView: UIView? = nil,
                rows: [CBMFormCellAttributes] = []) {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.headerView = headerView
        self.footerView = footerView
        self.rows = rows
    }
    
}

/// Defines individual rows of a tableview
public final class CBMFormCellAttributes {
    
    // MARK: Nested Types
    public enum CellType {
        case unknown
        case text
        case email
        case phone
        case digits
    }
    
    // MARK: Properties
    public let id: Int
    public let type: CellType
    public let totalRowCountInSection: Int
    public var title: String?
    public var placeholder: String?
    public var cellClass: AnyClass?
    public var didSelectClosure: ((CBMFormCellAttributes) -> Void)?
    public var didBeginEditingClosure: ((CBMFormCellAttributes) -> Void)?
    public var didUpdateClosure: ((CBMFormCellAttributes) -> Void)?
    public var isValidClosure: ((AnyObject?) -> Bool)?
    public var value: AnyObject? {
        didSet {
            didUpdateClosure?(self)
        }
    }
    
    // MARK: Initalization
    public init(id: Int,
                type: CellType,
                totalRowCountInSection: Int,
                title: String? = nil,
                placeholder: String? = nil,
                cellClass: AnyClass? = nil,
                didSelectClosure: ((CBMFormCellAttributes) -> Void)? = nil,
                didBeginEditingClosure: ((CBMFormCellAttributes) -> Void)? = nil,
                didUpdateClosure: ((CBMFormCellAttributes) -> Void)? = nil,
                isValidClosure: ((AnyObject?) -> Bool)? = nil) {
        self.id = id
        self.type = type
        self.totalRowCountInSection = totalRowCountInSection
        self.title = title
        self.placeholder = placeholder
        self.cellClass = cellClass
        self.didSelectClosure = didSelectClosure
        self.didBeginEditingClosure = didBeginEditingClosure
        self.didUpdateClosure = didUpdateClosure
        self.isValidClosure = isValidClosure
    }
    
}
