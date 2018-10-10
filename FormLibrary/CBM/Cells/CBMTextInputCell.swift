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
    
    let textField = CBMFormTextField()
    let toolbar = CBMCustomKeyboardToolBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    
    override func configure() {
        setupTextField()
        setupToolbar()
    }
    
    override func update() {
        textField.borderActiveColor = .blue
        textField.borderInactiveColor = .lightGray
        textField.placeholderText = cellAttributes?.title
        textField.placeholderColor = .lightGray
        textField.text = cellAttributes?.value as? String
        textField.updateForValidState(cellAttributes?.isValidClosure?(nil) ?? false)
        
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
        let isValid = attributes.isValidClosure?(text as AnyObject) ?? false
        self.textField.updateForValidState(isValid)
        attributes.value = text as AnyObject
        textField.text = attributes.type == .phone ? text.phoneRepresentable() : text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let attributes = self.cellAttributes else { return }
        cellAttributes?.didBeginEditingClosure?(attributes)
        self.textField.animateDidBeginEditing()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        self.textField.animateDidEndEditing()
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
    
    private func setupTextField() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        contentView.addSubview(textField)
        textField.anchor(contentView.topAnchor,
                         left: contentView.leftAnchor,
                         bottom: contentView.bottomAnchor,
                         right: contentView.rightAnchor,
                         leftConstant: 15,
                         bottomConstant: 5,
                         rightConstant: 15,
                         heightConstant: 70)
    }
    
}

open class FormDateCell: CBMFormRootCell {
    
    // MARK: Properties
    private let valueLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let hiddenTextField = UITextField(frame: CGRect.zero)
    
    private let defaultDateFormatter = DateFormatter()
    
    // MARK: FormBaseCell
    
    open override func configure() {
        super.configure()
        contentView.addSubview(hiddenTextField)
        hiddenTextField.inputView = datePicker
        hiddenTextField.isAccessibilityElement = false
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(FormDateCell.valueChanged(_:)), for: .valueChanged)
        
        setupLabel()
    }
    
    open override func update() {
        super.update()
        
        valueLabel.text = "Date Cell"
        
//        if let showsInputToolbar = rowDescriptor?.configuration.cell.showsInputToolbar , showsInputToolbar && hiddenTextField.inputAccessoryView == nil {
//            hiddenTextField.inputAccessoryView = inputAccesoryView()
//        }
        
        //titleLabel.text = cellAttributes?.title
        
//        if let rowType = cellAttributes?.type {
//            switch rowType {
//            case .date:
//                datePicker.datePickerMode = .date
//                defaultDateFormatter.dateStyle = .long
//                defaultDateFormatter.timeStyle = .none
//            case .time:
//                datePicker.datePickerMode = .time
//                defaultDateFormatter.dateStyle = .none
//                defaultDateFormatter.timeStyle = .short
//            default:
//                datePicker.datePickerMode = .dateAndTime
//                defaultDateFormatter.dateStyle = .long
//                defaultDateFormatter.timeStyle = .short
//            }
//        }
        
        if let date = cellAttributes?.value as? Date {
            datePicker.date = date
            valueLabel.text = getDateFormatter().string(from: date)
        }
    }
    
    private func setupLabel() {
        contentView.addSubview(valueLabel)
        valueLabel.anchorCenterYToSuperview()
        valueLabel.anchor(contentView.topAnchor, bottom: contentView.bottomAnchor, topConstant: 20, bottomConstant: 20)
    }
    
    open override class func formViewController(_ formViewController: CBMFormTableViewController, didSelectRow selectedRow: CBMFormRootCell) {
        guard let row = selectedRow as? FormDateCell else { return }
        
        if row.cellAttributes?.value == nil {
            let date = Date()
            row.cellAttributes?.value = date as AnyObject
            row.valueLabel.text = row.getDateFormatter().string(from: date)
            row.update()
        }
        
        row.hiddenTextField.becomeFirstResponder()
    }
    
    // MARK: Actions
    
    @objc internal func valueChanged(_ sender: UIDatePicker) {
        cellAttributes?.value = sender.date as AnyObject
        valueLabel.text = getDateFormatter().string(from: sender.date)
        update()
    }
    
    // MARK: Private interface
    
    fileprivate func getDateFormatter() -> DateFormatter {
        return DateFormatter()
//        guard let dateFormatter = cellAttributes?.configuration.date.dateFormatter else { return defaultDateFormatter }
//        return dateFormatter
    }
}
