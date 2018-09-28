//
//  ExampleFormTableViewController.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/25/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

final class CBMUserInfoFormViewController: CBMFormTableViewController {

    var viewModel: CBMUserInfoFormViewModel! //Set in init
    var screenType: ScreenType = .generalInfo
    
    // MARK: - Properties
    private let headerView = CBMUserInfoHeaderView()
    private let footerView = CBMUserInfoFooterView()
    
    lazy var didUpdateTextValueClosure: (CBMFormCellAttributes) -> Void = { [weak self] attr in
        guard let `self` = self else { return }
        switch self.screenType {
        case .generalInfo:
            guard let tag = GeneralPageTag(rawValue: attr.id) else { return }
            self.viewModel.update(value: attr.value, for: tag)
        case .addressInfo:
            guard let tag = AddressPageTag(rawValue: attr.id) else { return }
            self.viewModel.update(value: attr.value, for: tag)
        }
        self.viewModel.checkIfFormValid(given: self.sections)
    }
    
    // MARK: - Initalization
    convenience init(viewModel: CBMUserInfoFormViewModel,
                     screenType: ScreenType,
                     tableViewStyle: UITableViewStyle) {
        self.init(style: tableViewStyle)
        self.viewModel = viewModel
        self.screenType = screenType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.setFormIsValid = { [weak self] isValid in
            self?.footerView.adjustValidState(isValid)
        }
        
        self.createSections(for: screenType)
    }
    
    private func createSections(for screenType: ScreenType) {
        let rows = createRows(for: screenType)
        configureHeaderView(for: screenType)
        configureFooterView(for: screenType)
        
        self.sections = [ CBMFormSectionAttributes(headerView: headerView,
                                                  footerView: footerView,
                                                  rows: rows) ]
    }
    
    private func createRows(for screenType: ScreenType) -> [CBMFormCellAttributes] {
        switch screenType {
        case .generalInfo:
            return [
                createFirstNameRow(),
                createLastNameRow(),
                createEmailRow(),
                createPhoneRow(),
                createCreditCardRow()
            ]
        case .addressInfo:
            return [
                createStreetNameRow(),
                createUnitRow(),
                createCityRow(),
                createStateRow(),
                createZipCodeRow()
            ]
        }
    }
    
}

// MARK: - Actions
extension CBMUserInfoFormViewController {
    
    @objc func didSelectNextButton(_ sender: UIButton) {
        viewModel.didSelectFormCompleted()
    }
    
    @objc func didSelectCancelButton(_ sender: UIButton) {
        viewModel.didSelectCancel()
    }
    
}

// MARK: - General Info Row Setup
extension CBMUserInfoFormViewController {
    
    private func createFirstNameRow() -> CBMFormCellAttributes {
        let isValidClosure: (AnyObject?) -> Bool = { value in
            guard let text = value as? String else { return false }
            return text.count > 3
        }
        
        return CBMFormCellAttributes(id: GeneralPageTag.firstName.rawValue,
                                     type: .text,
                                     totalRowCountInSection: GeneralPageTag.allTags.count,
                                     title: GeneralPageConst.firstNameTitle,
                                     placeholder: GeneralPageConst.firstNameTitle,
                                     cellClass: CBMTextInputCell.self,
                                     didUpdateClosure: didUpdateTextValueClosure,
                                     isValidClosure: isValidClosure)
    }
    
    private func createLastNameRow() -> CBMFormCellAttributes {
        let isValidClosure: (AnyObject?) -> Bool = { value in
            guard let text = value as? String else { return false }
            return text.count > 3
        }
    
        return CBMFormCellAttributes(id: GeneralPageTag.lastName.rawValue,
                                     type: .text,
                                     totalRowCountInSection: GeneralPageTag.allTags.count,
                                     title: GeneralPageConst.lastNameTitle,
                                     placeholder: GeneralPageConst.lastNameTitle,
                                     cellClass: CBMTextInputCell.self,
                                     didUpdateClosure: didUpdateTextValueClosure,
                                     isValidClosure: isValidClosure)
    }
    
    private func createEmailRow() -> CBMFormCellAttributes {
        let isValidClosure: (AnyObject?) -> Bool = { value in
            guard let text = value as? String else { return false }
            return text.contains("@") && text.contains(".") && text.count > 3
        }
        
        return CBMFormCellAttributes(id: GeneralPageTag.email.rawValue,
                                     type: .email,
                                     totalRowCountInSection: GeneralPageTag.allTags.count,
                                     title: GeneralPageConst.emailTitle,
                                     placeholder: GeneralPageConst.emailTitle,
                                     cellClass: CBMTextInputCell.self,
                                     didUpdateClosure: didUpdateTextValueClosure,
                                     isValidClosure: isValidClosure)
    }
    
    private func createPhoneRow() -> CBMFormCellAttributes {
        let isValidClosure: (AnyObject?) -> Bool = { value in
            guard let text = value as? String else { return false }
            return text.digitsOnly.count == 10
        }
        
        return CBMFormCellAttributes(id: GeneralPageTag.phone.rawValue,
                                     type: .phone,
                                     totalRowCountInSection: GeneralPageTag.allTags.count,
                                     title: GeneralPageConst.phoneTitle,
                                     placeholder: GeneralPageConst.phoneTitle,
                                     cellClass: CBMTextInputCell.self,
                                     didUpdateClosure: didUpdateTextValueClosure,
                                     isValidClosure: isValidClosure)
    }
    
    private func createCreditCardRow() -> CBMFormCellAttributes {
        let isValidClosure: (AnyObject?) -> Bool = { value in
            guard let text = value as? String,
                  let _ = Int(text) else { return false }
            return text.count == 4
        }
        
        return CBMFormCellAttributes(id: GeneralPageTag.creditCard.rawValue,
                                     type: .digits,
                                     totalRowCountInSection: GeneralPageTag.allTags.count,
                                     title: GeneralPageConst.creditCardTitle,
                                     placeholder: GeneralPageConst.creditCardTitle,
                                     cellClass: CBMTextInputCell.self,
                                     didUpdateClosure: didUpdateTextValueClosure,
                                     isValidClosure: isValidClosure)
    }
    
}

// MARK: - Address Info Row Setup
extension CBMUserInfoFormViewController {
    
    private func createStreetNameRow() -> CBMFormCellAttributes {
        let isValidClosure: (AnyObject?) -> Bool = { value in
            guard let text = value as? String else { return false }
            return text.count > 3
        }
        
        return CBMFormCellAttributes(id: AddressPageTag.street.rawValue,
                                     type: .text,
                                     totalRowCountInSection: AddressPageTag.allTags.count,
                                     title: AddressPageConst.addressTitle,
                                     placeholder: AddressPageConst.addressTitle,
                                     cellClass: CBMTextInputCell.self,
                                     didUpdateClosure: didUpdateTextValueClosure,
                                     isValidClosure: isValidClosure)
    }
    
    private func createUnitRow() -> CBMFormCellAttributes {
        let isValidClosure: (AnyObject?) -> Bool = { value in
            guard let text = value as? String else { return false }
            return text.count >= 1
        }
        
        return CBMFormCellAttributes(id: AddressPageTag.unit.rawValue,
                                     type: .text,
                                     totalRowCountInSection: AddressPageTag.allTags.count,
                                     title: AddressPageConst.unitTitle,
                                     placeholder: AddressPageConst.unitTitle,
                                     cellClass: CBMTextInputCell.self,
                                     didUpdateClosure: didUpdateTextValueClosure,
                                     isValidClosure: isValidClosure)
    }
    
    private func createCityRow() -> CBMFormCellAttributes {
        let isValidClosure: (AnyObject?) -> Bool = { value in
            guard let text = value as? String else { return false }
            return text.count > 3
        }
        
        return CBMFormCellAttributes(id: AddressPageTag.city.rawValue,
                                     type: .text,
                                     totalRowCountInSection: AddressPageTag.allTags.count,
                                     title: AddressPageConst.cityTitle,
                                     placeholder: AddressPageConst.cityTitle,
                                     cellClass: CBMTextInputCell.self,
                                     didUpdateClosure: didUpdateTextValueClosure,
                                     isValidClosure: isValidClosure)
    }
    
    private func createStateRow() -> CBMFormCellAttributes {
        let isValidClosure: (AnyObject?) -> Bool = { value in
            guard let text = value as? String else { return false }
            return text.count > 1
        }
        
        return CBMFormCellAttributes(id: AddressPageTag.state.rawValue,
                                     type: .text,
                                     totalRowCountInSection: AddressPageTag.allTags.count,
                                     title: AddressPageConst.stateTitle,
                                     placeholder: AddressPageConst.stateTitle,
                                     cellClass: CBMTextInputCell.self,
                                     didUpdateClosure: didUpdateTextValueClosure,
                                     isValidClosure: isValidClosure)
    }
    
    private func createZipCodeRow() -> CBMFormCellAttributes {
        let isValidClosure: (AnyObject?) -> Bool = { value in
            guard let text = value as? String,
                let _ = Int(text) else { return false }
            return text.count == 5
        }
        
        return CBMFormCellAttributes(id: AddressPageTag.zipcode.rawValue,
                                     type: .digits,
                                     totalRowCountInSection: AddressPageTag.allTags.count,
                                     title: AddressPageConst.zipCodeTitle,
                                     placeholder: AddressPageConst.cityTitle,
                                     cellClass: CBMTextInputCell.self,
                                     didUpdateClosure: didUpdateTextValueClosure,
                                     isValidClosure: isValidClosure)
    }
    
}

// MARK: Header & Footer View Setup
extension CBMUserInfoFormViewController {
    
    private func configureHeaderView(for screenType: ScreenType) {
        switch screenType {
        case .generalInfo:
            headerView.configure(with: CBMUserInfoHeaderView.Properties(topLabelText: GeneralPageConst.topHeaderLabelText, bottomLabelText: GeneralPageConst.bottomHeaderLabelText))
        case .addressInfo:
            headerView.configure(with: CBMUserInfoHeaderView.Properties(topLabelText: AddressPageConst.topHeaderLabelText, bottomLabelText: nil))
        }
    }
    
    private func configureFooterView(for screenType: ScreenType) {
        switch screenType {
        case .generalInfo:
            footerView.configure(with: CBMUserInfoFooterView.Properties(topLabelText: GeneralPageConst.footerTopLabelText, topButtonTitle: GeneralPageConst.footerTopButtonTitle, bottomButtonTitle: GeneralPageConst.footerBottomButtonTitle, page: .generalInfo))
        case .addressInfo:
            footerView.configure(with: CBMUserInfoFooterView.Properties(topLabelText: AddressPageConst.footerTopLabelText, topButtonTitle: AddressPageConst.footerTopButtonTitle, bottomButtonTitle: AddressPageConst.footerBottomButtonTitle, page: .addressInfo))
        }
        footerView.topButton.addTarget(self, action: #selector(didSelectNextButton), for: .touchUpInside)
        footerView.bottomButton.addTarget(self, action: #selector(didSelectCancelButton), for: .touchUpInside)
    }
    
}

// MARK: Constants
extension CBMUserInfoFormViewController {
    
    struct GeneralPageConst {
        /// Header View
        static let topHeaderLabelText = "Before We Delete It We Have To I.D. It"
        static let bottomHeaderLabelText = "This subscription is registred to..."
        
        /// Footer View
        static let footerTopButtonTitle = "Next"
        static let footerBottomButtonTitle = "Cancel"
        static let footerTopLabelText = "Cancellations take 3-7 days and are not guaranteed."
        
        /// Cells
        static let firstNameTitle = "First Name"
        static let lastNameTitle = "Last Name"
        static let emailTitle = "Email Address"
        static let phoneTitle = "Phone Number"
        static let creditCardTitle = "Last Four Digits on Card"
    }
    
    struct AddressPageConst {
        /// Header View
        static let topHeaderLabelText = "Add Your Billing Address"
        static let footerTopButtonTitle = "Complete"
        
        /// Footer View
        static let footerBottomButtonTitle = "Cancel"
        static let footerTopLabelText = "Cancellations take 3-7 days and are not guaranteed."
        
        /// Cells
        static let addressTitle = "Address"
        static let unitTitle = "Unit (optional)"
        static let cityTitle = "City"
        static let stateTitle = "State"
        static let zipCodeTitle = "Zip Code"
    }
    
}

//MARK: Nested Types
extension CBMUserInfoFormViewController {
    
    enum GeneralPageTag: Int {
        case firstName
        case lastName
        case email
        case phone
        case creditCard
        
        static let allTags: [GeneralPageTag] = [.firstName, .lastName, .email, .phone, .creditCard]
    }
    
    enum AddressPageTag: Int {
        case street
        case unit
        case city
        case state
        case zipcode
        
        static let allTags: [AddressPageTag] = [.street, .unit, .city, .state, .zipcode]
    }
    
    enum ScreenType {
        case generalInfo
        case addressInfo
    }
    
}




