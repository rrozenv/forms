//
//  CBMUserInfoHeaderView.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/27/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

final class CBMUserInfoHeaderView: UIView {
    
    struct Properties {
        let topLabelText: String
        let bottomLabelText: String?
    }
    
    let topLabel = UILabel()
    let bottomLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    func configure(with properties: Properties) {
        topLabel.text = properties.topLabelText
        bottomLabel.text = properties.bottomLabelText
        bottomLabel.isHidden = properties.bottomLabelText == nil
    }
    
    private func setupUI() {
        topLabel.textAlignment = .center
        bottomLabel.textAlignment = .center
    }
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        
        self.addSubview(stackView)
        stackView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 30, leftConstant: 15, bottomConstant: 30, rightConstant: 15)
    }
    
}
