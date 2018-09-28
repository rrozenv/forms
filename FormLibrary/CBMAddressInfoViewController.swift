//
//  CBMAddressInfoViewController.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/26/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

//final class CBMAddressInfoViewController: CBMFormTableViewController {
//    
//    var viewModel: CBMGeneralUserInfoFormViewModel!
//    
//    let headerView = CBMUserInfoHeaderView()
//    let footerView = CBMUserInfoFooterView()
//    
//    lazy var didUpdateTextValueClosure: (CBMFormCellAttributes) -> Void = { [weak self] attr in
//        guard let `self` = self else { return }
//        //self.viewModel.update(value: attr.value, for: attr.id)
//        self.viewModel.checkIfFormValid(given: self.sections)
//    }
//    
//    convenience init(viewModel: CBMGeneralUserInfoFormViewModel, tableViewStyle: UITableViewStyle) {
//        self.init(style: tableViewStyle)
//        self.viewModel = viewModel
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .white
//        bindViewModel()
//    }
//    
//    func bindViewModel() {
//        viewModel.setFormIsValid = { [weak self] isValid in
//            self?.footerView.adjustValidState(isValid)
//        }
//        
//        self.createSections()
//    }
//    
//    func createSections() {
//        let rows = [
//            createStreetNameRow(),
//            createUnitRow(),
//            createCityRow(),
//            createStateRow(),
//            createZipCodeRow()
//        ]
//        
//        configureHeaderView()
//        configureFooterView()
//        
//        self.sections = [CBMFormSectionAttributes(headerView: headerView, footerView: footerView, rows: rows)]
//    }
//    
//    @objc func didSelectNextButton(_ sender: UIButton) {
//        viewModel.didSelectFormCompleted()
//    }
//    
//    @objc func didSelectCancelButton(_ sender: UIButton) {
//        viewModel.didSelectCancel()
//    }
//    
//    private func configureHeaderView() {
//        headerView.configure(with: CBMUserInfoHeaderView.Properties(topLabelText: Constants.topHeaderLabelText, bottomLabelText: nil))
//    }
//    
//    private func configureFooterView() {
//        footerView.topButton.addTarget(self, action: #selector(didSelectNextButton), for: .touchUpInside)
//        footerView.bottomButton.addTarget(self, action: #selector(didSelectCancelButton), for: .touchUpInside)
//        footerView.configure(with: CBMUserInfoFooterView.Properties(topLabelText: Constants.footerTopLabelText, topButtonTitle: Constants.footerTopButtonTitle, bottomButtonTitle: Constants.footerBottomButtonTitle, page: .addressInfo))
//    }
//    
//}
//
//extension CBMAddressInfoViewController {
//    
//    private func createStreetNameRow() -> CBMFormCellAttributes {
//        let isValidClosure: (AnyObject?) -> Bool = { value in
//            guard let text = value as? String else { return false }
//            return text.count > 5
//        }
//      
//        return CBMFormCellAttributes(id: Tag.street.rawValue,
//                                     type: .text,
//                                     totalRowCountInSection: Tag.allTags.count,
//                                     title: Constants.addressTitle,
//                                     placeholder: Constants.addressTitle,
//                                     cellClass: CBMTextInputCell.self,
//                                     didUpdateClosure: didUpdateTextValueClosure,
//                                     isValidClosure: isValidClosure)
//    }
//    
//    private func createUnitRow() -> CBMFormCellAttributes {
//        let isValidClosure: (AnyObject?) -> Bool = { value in
//            guard let text = value as? String else { return false }
//            return text.count > 5
//        }
//
//        return CBMFormCellAttributes(id: Tag.unit.rawValue,
//                                     type: .text,
//                                     totalRowCountInSection: Tag.allTags.count,
//                                     title: Constants.unitTitle,
//                                     placeholder: Constants.unitTitle,
//                                     cellClass: CBMTextInputCell.self,
//                                     didUpdateClosure: didUpdateTextValueClosure,
//                                     isValidClosure: isValidClosure)
//    }
//    
//    private func createCityRow() -> CBMFormCellAttributes {
//        let isValidClosure: (AnyObject?) -> Bool = { value in
//            guard let text = value as? String else { return false }
//            return text.count > 5
//        }
//        
//        return CBMFormCellAttributes(id: Tag.city.rawValue,
//                                     type: .text,
//                                     totalRowCountInSection: Tag.allTags.count,
//                                     title: Constants.cityTitle,
//                                     placeholder: Constants.cityTitle,
//                                     cellClass: CBMTextInputCell.self,
//                                     didUpdateClosure: didUpdateTextValueClosure,
//                                     isValidClosure: isValidClosure)
//    }
//    
//    private func createStateRow() -> CBMFormCellAttributes {
//        let isValidClosure: (AnyObject?) -> Bool = { value in
//            guard let text = value as? String else { return false }
//            return text.count > 5
//        }
//      
//        return CBMFormCellAttributes(id: Tag.state.rawValue,
//                                     type: .text,
//                                     totalRowCountInSection: Tag.allTags.count,
//                                     title: Constants.stateTitle,
//                                     placeholder: Constants.stateTitle,
//                                     cellClass: CBMTextInputCell.self,
//                                     didUpdateClosure: didUpdateTextValueClosure,
//                                     isValidClosure: isValidClosure)
//    }
//    
//    private func createZipCodeRow() -> CBMFormCellAttributes {
//        let isValidClosure: (AnyObject?) -> Bool = { value in
//            guard let text = value as? String,
//                let _ = Int(text) else { return false }
//            return text.count == 4
//        }
//       
//        return CBMFormCellAttributes(id: Tag.zipcode.rawValue,
//                                     type: .text,
//                                     totalRowCountInSection: Tag.allTags.count,
//                                     title: Constants.zipCodeTitle,
//                                     placeholder: Constants.cityTitle,
//                                     cellClass: CBMTextInputCell.self,
//                                     didUpdateClosure: didUpdateTextValueClosure,
//                                     isValidClosure: isValidClosure)
//    }
//    
//}
//
////MARK: Constants
//extension CBMAddressInfoViewController {
//    struct Constants {
//        /// Header View
//        static let topHeaderLabelText = "Add Your Billing Address"
//        static let footerTopButtonTitle = "Complete"
//        
//        /// Footer View
//        static let footerBottomButtonTitle = "Cancel"
//        static let footerTopLabelText = "Cancellations take 3-7 days and are not guaranteed."
//        
//        /// Cells
//        static let addressTitle = "Address"
//        static let unitTitle = "Unit (optional)"
//        static let cityTitle = "City"
//        static let stateTitle = "State"
//        static let zipCodeTitle = "Zip Code"
//    }
//}
//
////MARK: Nested Types
//extension CBMAddressInfoViewController {
//    
//    enum Tag: Int {
//        case street
//        case unit
//        case city
//        case state
//        case zipcode
//        
//        static let allTags: [Tag] = [.street, .unit, .city, .state, .zipcode]
//    }
//    
//}
