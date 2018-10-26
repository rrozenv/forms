//
//  CBMUserInfoHeaderView.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/27/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

final class CBMFormNavTitleView: UIView {
    
    let topLabel = UILabel()
    let imageButton = UIButton()
    let bottomLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageButton.backgroundColor = .red
        topLabel.numberOfLines = 1
        topLabel.lineBreakMode = .byTruncatingTail
        bottomLabel.textAlignment = .center
    }
    
    private func setupContraints() {
        imageButton.anchor(widthConstant: 14.0, heightConstant: 14.0)
        
        let topStackView = UIStackView(arrangedSubviews: [topLabel, imageButton])
        topStackView.axis = .horizontal
        topStackView.distribution = .fillProportionally
        
        self.addSubview(topStackView)
        topStackView.anchor(self.topAnchor, left: self.leftAnchor, right: self.rightAnchor)
        
        self.addSubview(bottomLabel)
        bottomLabel.anchor(topStackView.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 2)
    }
    
}

final class CBMUserInfoHeaderView: CBMFormRootHeaderFooterView {
    
    struct Properties {
        let topLabelText: String
        let bottomLabelText: String?
    }
    
    let topLabel = UILabel()
    let bottomLabel = UILabel()
    
    override func update() {
        super.update()
        setupUI()
        setupConstraints()
    }
    
//    func configure(with properties: Properties) {
//        topLabel.text = properties.topLabelText
//        bottomLabel.text = properties.bottomLabelText
//        bottomLabel.isHidden = properties.bottomLabelText == nil
//    }
    
    private func setupUI() {
        topLabel.text = cellAttributes?.title
        bottomLabel.text = cellAttributes?.subTitle
        topLabel.textAlignment = .center
        bottomLabel.textAlignment = .center
        bottomLabel.isHidden = true
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
