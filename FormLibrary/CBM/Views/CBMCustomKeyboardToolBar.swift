//
//  CBMCustomKeyboardToolBar.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/27/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

final class CBMCustomKeyboardToolBar: UIToolbar {
    
    var didSelectUpArrow: (() -> Void)?
    var didSelectDownArrow: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let downButton = UIBarButtonItem(title: "Down", style: .done, target: self, action: #selector(didSelectToolBarDownArrow(_:)))
        let upButton = UIBarButtonItem(title: "Up", style: .done, target: self, action: #selector(didSelectToolBarUpArrow(_:)))
        self.setItems([downButton, upButton], animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    @objc func didSelectToolBarDownArrow(_ sender: UIBarButtonItem) {
        didSelectDownArrow?()
    }
    
    @objc func didSelectToolBarUpArrow(_ sender: UIBarButtonItem) {
        didSelectUpArrow?()
    }
    
}
