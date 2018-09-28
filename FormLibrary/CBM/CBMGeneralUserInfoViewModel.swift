//
//  CBMGeneralUserInfoViewModel.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/26/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation

// MARK: Form Validateable Protocol
protocol CBMFormValidateable: class {
    var isFormValid: Bool { get set }
    func checkIfFormValid(given sections: [CBMFormSectionAttributes])
}

extension CBMFormValidateable {
    func checkIfFormValid(given sections: [CBMFormSectionAttributes]) {
        let validSections = sections.filter { section in
            let validRows = section.rows.filter { row in
                row.isValidClosure?(row.value as AnyObject) ?? false
            }
            return validRows.count == section.rows.count
        }
        self.isFormValid = validSections.count == sections.count
    }
}

// MARK: Form View Model Delegate
protocol CBMGeneralUserInfoFormViewModelDelegate: class {
    func didSelectFormCompleted(with userInfo: CBMCancelBillUserInfo, for screenType: CBMUserInfoFormViewController.ScreenType)
    func didSelectCancel()
}

final class CBMUserInfoFormViewModel: CBMFormValidateable {
    
    // MARK: Injected Properties
    var userInfo: CBMCancelBillUserInfo
    let screenType: CBMUserInfoFormViewController.ScreenType
    
    // MARK: View Controller Bindings
    var setFormIsValid: ((Bool) -> Void)?
    
    // MARK: Properties
    weak var delegate: CBMGeneralUserInfoFormViewModelDelegate?
    
    var isFormValid: Bool = false {
        didSet {
            setFormIsValid?(isFormValid)
        }
    }
    
    // MARK: Initalization
    init(userInfo: CBMCancelBillUserInfo, screenType: CBMUserInfoFormViewController.ScreenType) {
        self.userInfo = userInfo
        self.screenType = screenType
    }
    
}

// MARK: Public Interface
extension CBMUserInfoFormViewModel {

    func update(value: AnyObject?, for tag: CBMUserInfoFormViewController.GeneralPageTag) {
        switch tag {
        case .firstName: userInfo.firstName = value as? String
        case .lastName: userInfo.lastName = value as? String
        case .email: userInfo.email = value as? String
        case .phone: userInfo.phone = value as? String
        case .creditCard: userInfo.lastFourCreditDigits = Int((value as? String) ?? "")
        }
    }
    
    func update(value: AnyObject?, for tag: CBMUserInfoFormViewController.AddressPageTag) {
        switch tag {
        case .street: userInfo.street = value as? String
        case .unit: userInfo.unit = value as? String
        case .city: userInfo.city = value as? String
        case .state: userInfo.state = value as? String
        case .zipcode: userInfo.zipcode = Int((value as? String) ?? "")
        }
    }
    
    func didSelectFormCompleted() {
        delegate?.didSelectFormCompleted(with: userInfo, for: screenType)
    }
    
    func didSelectCancel() {
        delegate?.didSelectCancel()
    }
    
}




