//
//  Style.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/28/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

struct TextAttributes {
    let font: UIFont
    let color: UIColor
    let backgroundColor: UIColor?
    
    init(font: UIFont, color: UIColor, backgroundColor: UIColor? = nil) {
        self.font = font
        self.color = color
        self.backgroundColor = backgroundColor
    }
}

class Style {
    
    enum TextStyle {
        case navigationBar
        case title
        case subtitle
        case body
        case button
    }
    
    // MARK: - General Properties
    let backgroundColor: UIColor
    let attributesForStyle: (_ style: TextStyle) -> TextAttributes
    
    init(backgroundColor: UIColor,
         attributesForStyle: @escaping (_ style: TextStyle) -> TextAttributes) {
        self.backgroundColor = backgroundColor
        self.attributesForStyle = attributesForStyle
    }
    
    // MARK: - Convenience Getters
    func font(for style: TextStyle) -> UIFont {
        return attributesForStyle(style).font
    }
    
    func color(for style: TextStyle) -> UIColor {
        return attributesForStyle(style).color
    }
    
    func backgroundColor(for style: TextStyle) -> UIColor? {
        return attributesForStyle(style).backgroundColor
    }
    
    func apply(textStyle: TextStyle, to label: UILabel) {
        let attributes = attributesForStyle(textStyle)
        label.font = attributes.font
        label.textColor = attributes.color
        label.backgroundColor = attributes.backgroundColor
    }
    
    func apply(textStyle: TextStyle = .button, to button: UIButton) {
        let attributes = attributesForStyle(textStyle)
        button.setTitleColor(attributes.color, for: .normal)
        button.titleLabel?.font = attributes.font
        button.backgroundColor = attributes.backgroundColor
    }
    
//    var myAppAttributes: TextAttributes {
//        switch self {
//        case .navigationBar:
//            return TextAttributes(font: .myAppTitle, color: .myAppGreen, backgroundColor: .black)
//        case .title:
//            return TextAttributes(font: .myAppTitle, color: .myAppGreen)
//        case .subtitle:
//            return TextAttributes(font: .myAppSubtitle, color: .myAppBlue)
//        case .body:
//            return TextAttributes(font: .myAppBody, color: .black, backgroundColor: .white)
//        case .button:
//            return TextAttributes(font: .myAppSubtitle, color: .white, backgroundColor: .myAppRed)
//        }
//    }
    
}



