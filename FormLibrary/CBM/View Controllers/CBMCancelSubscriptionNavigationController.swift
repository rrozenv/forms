//
//  CBMCancelSubscriptionNavigationController.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/26/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

protocol CBMRoutable: class {
    associatedtype Screen
    func navigateTo(screen: Screen)
}

final class CBMCancelSubscriptionNavigationController: UINavigationController, CBMRoutable {

    enum Screen: Int {
        case generalInfo
        case addressInfo
        case confirmation
    }
    
    // MARK: Data Storage Container
    var userInfo: CBMCancelBillUserInfo = CBMCancelBillUserInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        bindViewModel()
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.popViewController(animated: true)
    }
    
    private func bindViewModel() {
        self.navigateTo(screen: .generalInfo)
    }
    
    func navigateTo(screen: Screen) {
        switch screen {
        case .generalInfo: toGeneralInfo()
        case .addressInfo: toEnterAddressData()
        case .confirmation: toConfirmation()
        }
    }
    
}

// MARK: Navigation
extension CBMCancelSubscriptionNavigationController {
    
    private func toGeneralInfo() {
        let vm = CBMUserInfoFormViewModel(userInfo: userInfo, screenType: .generalInfo)
        let vc = CBMUserInfoFormViewController(viewModel: vm, screenType: .generalInfo, tableViewStyle: .grouped)
        vm.delegate = self
        vc.viewModel = vm
        self.pushViewController(vc, animated: false)
    }
    
    private func toEnterAddressData() {
        let vm = CBMUserInfoFormViewModel(userInfo: userInfo, screenType: .addressInfo)
        let vc = CBMUserInfoFormViewController(viewModel: vm, screenType: .addressInfo, tableViewStyle: .grouped)
        vm.delegate = self
        vc.viewModel = vm
        self.pushViewController(vc, animated: true)
    }
    
    private func toConfirmation() {
        let vc = CBMConfirmationViewController()
        vc.configureUI(with: CBMConfirmationViewController.UIConfig(image: nil, topLabelText: Constants.confirmVCTopLabelText, bottomLabelText: Constants.confirmVCBottomLabelText))
        vc.timerCompleted = { [weak self] in
           self?.dismiss(animated: false, completion: { self?.dismiss(animated: true, completion: nil) })
        }
        self.present(vc, animated: true, completion: nil)
    }
    
}

// MARK: Form View Model Delegate
extension CBMCancelSubscriptionNavigationController: CBMGeneralUserInfoFormViewModelDelegate {
    
    func didSelectFormCompleted(with userInfo: CBMCancelBillUserInfo, for screenType: CBMUserInfoFormViewController.ScreenType) {
        self.userInfo = userInfo
        switch screenType {
        case .generalInfo: navigateTo(screen: .addressInfo)
        case .addressInfo: navigateTo(screen: .confirmation)
        }
    }
    
    func didSelectCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: Constants
extension CBMCancelSubscriptionNavigationController {
    
    struct Constants {
        static let confirmVCTopLabelText = "Going, Going..."
        static let confirmVCBottomLabelText = "Gone in 3-7 days. And you lowered your monthly bills."
    }
    
}

