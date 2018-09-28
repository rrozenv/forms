//
//  CBMFormSectionAttributes.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/25/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

public final class CBMFormSectionAttributes {
    
    // MARK: Properties
    public var rows: [CBMFormCellAttributes] = []
    public var headerTitle: String?
    public var footerTitle: String?
    public var headerView: UIView?
    public var footerView: UIView?
    
    // MARK: Init
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
