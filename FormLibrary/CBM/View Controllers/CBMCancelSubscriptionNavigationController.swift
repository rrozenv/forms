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
        self.navigationItem.title = "Hey"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //configureNavBar()
    }
    
    private func bindViewModel() {
        self.navigateTo(screen: .generalInfo)
    }
    
    func navigateTo(screen: Screen) {
        switch screen {
        case .generalInfo: toGeneralInfo()
        case .addressInfo: toEnterAddressData()
        case .confirmation:
            print(userInfo)
            toConfirmation()
        }
    }
    
    @objc func didSelectBackButton(_ sender: UIBarButtonItem) {
        self.popViewController(animated: true)
    }
    
}

// MARK: Navigation
extension CBMCancelSubscriptionNavigationController {
    
    private func toGeneralInfo() {
        let vm = CBMUserInfoFormViewModel(userInfo: userInfo, screenType: .generalInfo)
        let vc = CBMUserInfoFormViewController(viewModel: vm, screenType: .generalInfo, navBarTitleText: "My custom title", tableViewStyle: .grouped)
        vm.delegate = self
        vc.viewModel = vm
        self.pushViewController(vc, animated: false)
    }
    
    private func toEnterAddressData() {
        let vm = CBMUserInfoFormViewModel(userInfo: userInfo, screenType: .addressInfo)
        let vc = CBMUserInfoFormViewController(viewModel: vm, screenType: .addressInfo, navBarTitleText: "My custom title", tableViewStyle: .grouped)
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
        dismissByPush()
    }
    
}

// MARK: Constants
extension CBMCancelSubscriptionNavigationController {
    
    struct Constants {
        static let confirmVCTopLabelText = "Going, Going..."
        static let confirmVCBottomLabelText = "Gone in 3-7 days. And you lowered your monthly bills."
    }
    
}

extension UIViewController {
    
    func dismissByPush() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
}


class TestNavViewModel {
    
    var vmType: CBMUserInfoFormViewModel.Type
    
    init(vmType: CBMUserInfoFormViewModel.Type) {
        self.vmType = vmType
    }
    
    
}

