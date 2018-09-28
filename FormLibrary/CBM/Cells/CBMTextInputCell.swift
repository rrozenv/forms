//
//  CBMTextInputCell.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/25/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

class CBMTextInputCell: CBMFormRootCell {
    
    let label = UILabel()
    let textField = UITextField()
    let toolbar = CBMCustomKeyboardToolBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    
    override func configure() {
        setupTextField()
        setupLabel()
        setupToolbar()
    }
    
    override func update() {
        label.text = cellAttributes?.title
        textField.text = cellAttributes?.value as? String
        
        textField.isSecureTextEntry = false
        textField.clearButtonMode = .whileEditing
        
        if let type = cellAttributes?.type {
            switch type {
            case .phone:
                textField.keyboardType = .phonePad
            case .email:
                textField.keyboardType = .emailAddress
            case .digits:
                textField.keyboardType = .numberPad
            case .text, .unknown:
                textField.autocorrectionType = .default
                textField.autocapitalizationType = .sentences
                textField.keyboardType = .default
            }
        }
    }
    
}

extension CBMTextInputCell: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard var text = textField.text,
              let attributes = cellAttributes else { return }
        contentView.backgroundColor = attributes.isValidClosure?(text as AnyObject) ?? false ? .green : .white
        attributes.value = text as AnyObject
        textField.text = attributes.type == .phone ? text.phoneRepresentable() : text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let attributes = self.cellAttributes else { return }
        cellAttributes?.didBeginEditingClosure?(attributes)
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let attributes = cellAttributes,
//              let text = textField.text else { return true }
//        switch attributes.type {
//        case .phone:
//            let maxLength = 14
//            let currentString: NSString = text as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        default: return true
//        }
//    }
    
}

extension CBMTextInputCell {
    
    private func setupToolbar() {
        toolbar.didSelectDownArrow = { [weak self] in self?.didSelectDownArrow() }
        toolbar.didSelectUpArrow = { [weak self] in self?.didSelectUpArrow() }
        textField.inputAccessoryView = toolbar
    }
    
    private func didSelectUpArrow() {
        guard let id = cellAttributes?.id,
            id > 0 else {
                formViewController?.view.endEditing(true)
                return
        }
        let previousIndexPath = IndexPath(row: id - 1, section: 0)
        setTextFieldAsFirstResponder(at: previousIndexPath)
    }
    
    private func didSelectDownArrow() {
        guard let id = cellAttributes?.id,
            let maxRowCount = cellAttributes?.totalRowCountInSection,
            id < maxRowCount - 1 else {
                formViewController?.view.endEditing(true)
                return
        }
        let nextIndexPath = IndexPath(row: id + 1, section: 0)
        setTextFieldAsFirstResponder(at: nextIndexPath)
    }
    
    private func setTextFieldAsFirstResponder(at indexPath: IndexPath) {
        guard let cell = formViewController?.tableView.cellForRow(at: indexPath),
              let textField = UIView.findFirstTextField(in: cell) else { return }
        textField.becomeFirstResponder()
    }
    
}

extension CBMTextInputCell {
    
    private func setupLabel() {
        contentView.addSubview(label)
        label.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: textField.topAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 3)
    }
    
    private func setupTextField() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        contentView.addSubview(textField)
        textField.anchor(left: contentView.leftAnchor,
                         bottom: contentView.bottomAnchor,
                         right: contentView.rightAnchor,
                         leftConstant: 20,
                         bottomConstant: 10,
                         rightConstant: 20,
                         heightConstant: 50)
    }
    
}

