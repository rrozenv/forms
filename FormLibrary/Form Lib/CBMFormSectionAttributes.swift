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
    public var headerAttributes: CBMFormHeaderFooterAttributes?
    public var footerAttributes: CBMFormHeaderFooterAttributes?
    
    // MARK: Initialization
    public init(headerAttributes: CBMFormHeaderFooterAttributes? = nil,
                footerAttributes: CBMFormHeaderFooterAttributes? = nil,
                rows: [CBMFormCellAttributes] = []) {
        self.headerAttributes = headerAttributes
        self.footerAttributes = footerAttributes
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
    
//    public struct CellConfiguration {
//        public var cellClass:                AnyClass?
//        public var appearance:               [String : AnyObject]
//        public var placeholder:              String?
//        public var showsInputToolbar:        Bool
//        public var required:                 Bool
//        public var willUpdateClosure:        ((FormRowDescriptor) -> Void)?
//        public var didUpdateClosure:         ((FormRowDescriptor) -> Void)?
//        public var visualConstraintsClosure: ((FormBaseCell) -> [String])?
//
//        public init() {
//            cellClass = nil
//            appearance = [:]
//            placeholder = nil
//            showsInputToolbar = false
//            required = true
//            willUpdateClosure = nil
//            didUpdateClosure = nil
//            visualConstraintsClosure = nil
//        }
//    }
    
//
//    public struct RowConfiguration {
//        public var cell:      CellConfiguration
//        public var selection: SelectionConfiguration
//        public var button:    ButtonConfiguration
//        public var stepper:   StepperConfiguration
//        public var date:      DateConfiguration
//        public var userInfo:  [String : AnyObject]
//
//        init() {
//            cell = CellConfiguration()
//            selection = SelectionConfiguration()
//            button = ButtonConfiguration()
//            stepper = StepperConfiguration()
//            date = DateConfiguration()
//            userInfo = [:]
//        }
//    }
    
    public struct CellConfig {
        public var cellClass: AnyClass?
        public var didUpdateClosure: ((CBMFormCellAttributes) -> Void)?
        public var isValidClosure: ((AnyObject?) -> Bool)?
        
        public init() {
            cellClass = nil
            didUpdateClosure = nil
            isValidClosure = nil
        }
    }
    
    public struct TextFieldConfig {
        public var placeholder: String?
        public var didBeginEditingClosure: ((CBMFormCellAttributes) -> Void)?
        
        public init() {
            placeholder = nil
            didBeginEditingClosure = nil
        }
    }
    
    public struct DateConfig {
        public var dateFormatter: DateFormatter?
    }
    
    public struct Configuration {
        public var cell: CellConfig
        public var textField: TextFieldConfig
        public var date: DateConfig
        
        init() {
            cell = CellConfig()
            textField = TextFieldConfig()
            date = DateConfig()
        }
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
                cellClass: CBMFormRootCell.Type? = nil,
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

public final class CBMFormHeaderFooterAttributes {

    // MARK: Properties
    public var view: CBMFormRootHeaderFooterView
    public var title: String?
    public var subTitle: String?
    public var didSelectClosure: ((CBMFormCellAttributes) -> Void)?
    
    deinit {
        print("Footer attributes deinit")
    }
    
    // MARK: Initalization
    public init(view: CBMFormRootHeaderFooterView,
                title: String? = nil,
                subTitle: String? = nil,
                didSelectClosure: ((CBMFormCellAttributes) -> Void)? = nil) {
        self.view = view
        self.title = title
        self.subTitle = subTitle
        self.didSelectClosure = didSelectClosure
    }
    
}
