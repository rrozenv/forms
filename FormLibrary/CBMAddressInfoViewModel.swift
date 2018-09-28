//
//  CBMAddressInfoViewModel.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/26/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    let startFlowButton = UIButton()
    let confirmButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupButton()
        setupConfirmButton()
    }
    
    @objc func didSelectStartFlow(_ sender: UIButton) {
        self.present(CBMCancelSubscriptionNavigationController(), animated: true, completion: nil)
    }
    
    @objc func didSelectConfirmButton(_ sender: UIButton) {
        let vc = CBMConfirmationViewController()
        vc.configureUI(with: CBMConfirmationViewController.UIConfig(image: nil, topLabelText: "Going, Going...", bottomLabelText: "Gone in 3-7 days. And you lowered your monthly bills."))
        self.present(vc, animated: true, completion: nil)
    }
    
    private func setupButton() {
        startFlowButton.backgroundColor = .blue
        startFlowButton.setTitle("Start Flow", for: .normal)
        startFlowButton.addTarget(self, action: #selector(didSelectStartFlow), for: .touchUpInside)
        
        view.addSubview(startFlowButton)
        startFlowButton.anchorCenterSuperview()
        startFlowButton.anchor(widthConstant: 100, heightConstant: 50)
    }
    
    private func setupConfirmButton() {
        confirmButton.backgroundColor = .yellow
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.addTarget(self, action: #selector(didSelectConfirmButton), for: .touchUpInside)
        
        view.addSubview(confirmButton)
        confirmButton.anchorCenterXToSuperview()
        confirmButton.anchor(startFlowButton.bottomAnchor, bottomConstant: 10, widthConstant: 100, heightConstant: 50)
    }
}


