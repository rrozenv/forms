//
//  CBMUserInfoFooterView.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/27/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

final class CBMUserInfoFooterView: UIView {
    
    enum Props {
        case topLabel(Style)
        case bottomLabel(Style)
    }
    
    struct Properties {
        let topLabelText: String?
        let topButtonTitle: String
        let bottomButtonTitle: String
        let page: CBMUserInfoFormViewController.ScreenType
    }
    
    let topLabelContainerView = UIView()
    let topLabel = UILabel()
    let topButton = UIButton()
    let bottomButton = UIButton()
    //let style: Style
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        setupConstraints()
//    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
//    init(style: Style) {
//        //self.style = style
//        super.init(frame: .zero)
//        setupUI()
//        setupConstraints()
//    }
//    
//    init(props: [Props]) {
//        super.init(frame: .zero)
//        setupUI()
//        setupConstraints()
//    }
    
    func configure(with properties: Properties) {
        topButton.setTitle(properties.topButtonTitle, for: .normal)
        bottomButton.setTitle(properties.bottomButtonTitle, for: .normal)
        topLabel.text = properties.topLabelText
        topLabelContainerView.isHidden = properties.page == .generalInfo
        topButton.backgroundColor = .gray
        topButton.isEnabled = false
    }
    
    func adjustValidState(_ isValid: Bool) {
        topButton.backgroundColor = isValid ? .blue : .gray
        topButton.isEnabled = isValid
    }
    
    private func setupUI() {
        topLabelContainerView.backgroundColor = .gray
        topLabel.textAlignment = .center
        topButton.setTitleColor(.white, for: .normal)
        bottomButton.backgroundColor = .white
        bottomButton.setTitleColor(.blue, for: .normal)
    }
    
    private func setupConstraints() {
        topLabelContainerView.anchor(heightConstant: 40)
        
        topLabelContainerView.addSubview(topLabel)
        topLabel.anchorCenterYToSuperview()
        topLabel.anchor(left: topLabelContainerView.leftAnchor, right: topLabelContainerView.rightAnchor, leftConstant: 15, rightConstant: 15)
        
        topButton.anchor(heightConstant: 50)
        bottomButton.anchor(heightConstant: 50)
        
        let stackView = UIStackView(arrangedSubviews: [topLabelContainerView, topButton, bottomButton])
        stackView.spacing = 9.0
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        
        self.addSubview(stackView)
//        stackView.anchorCenterSuperview()
//        stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        stackView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 30, leftConstant: 15, bottomConstant: 30, rightConstant: 15)
    }
    
}
