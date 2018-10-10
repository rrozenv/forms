//
//  CBMFormTextField.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 10/10/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

class CBMFormTextField: UITextField {
    
    // MARK: Public Border Properties
    var borderThickness: (active: CGFloat, inactive: CGFloat)
    var borderInactiveColor: UIColor
    var borderActiveColor: UIColor

    // MARK: Public Placeholder Properties
    var placeholderColor: UIColor
    var placeholderFontScale: CGFloat
    var placeholderText: String?
    var customFont: UIFont
    
    // MARK: Private Properties
    private var rightPadding: CGFloat = 0.0
    private let placeholderInsets: CGPoint
    private let textFieldInsets: CGPoint
    private var currentPlaceholderOrigin: CGPoint = CGPoint.zero
    
    // MARK: Views
    private let placeholderLabel = UILabel()
    private let rightImageView = UIImageView()
    private let borderView = UIView()
    
    // MARK: Initalization
    init(frame: CGRect = .zero,
         placeholder: String? = nil,
         font: UIFont = UIFont.systemFont(ofSize: 16),
         placeholderColor: UIColor = .lightGray,
         placeholderFontScale: CGFloat = 0.65,
         borderInactiveColor: UIColor = .lightGray,
         borderActiveColor: UIColor = .blue,
         borderThickness: (active: CGFloat, inactive: CGFloat) = (active: 1, inactive: 1),
         placeholderInsets: CGPoint = CGPoint(x: 0, y: 8),
         textFieldInsets: CGPoint = CGPoint(x: 0, y: 12),
         rightImage: UIImage? = nil) {
        self.placeholderLabel.text = placeholder
        self.customFont = font
        self.placeholderColor = placeholderColor
        self.placeholderFontScale = placeholderFontScale
        self.borderInactiveColor = borderInactiveColor
        self.borderActiveColor = borderActiveColor
        self.borderThickness = borderThickness
        self.placeholderInsets = placeholderInsets
        self.textFieldInsets = textFieldInsets
    
        super.init(frame: frame)
        setupRightImageView(with: rightImage)
        setupBorderView()
    }
    
    required public init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Overrides
    override func draw(_ rect: CGRect) {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = customFont
        updateBorderView(isActive: false)
        updatePlaceholder()
        addSubview(placeholderLabel)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: textFieldInsets.x,
                      y: textFieldInsets.y,
                      width: bounds.size.width - textFieldInsets.x - rightPadding,
                      height: bounds.size.height)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: textFieldInsets.x,
                      y: textFieldInsets.y,
                      width: bounds.size.width - textFieldInsets.x - rightPadding,
                      height: bounds.size.height)
    }

}

// MARK: - Public Interface
extension CBMFormTextField {
    
    /// Should call in textFieldDidBeginEditing
    func animateDidBeginEditing() {
        if let text = text, text.isEmpty {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: ({
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: self.placeholderLabel.frame.origin.y)
                self.placeholderLabel.alpha = 0
                self.placeholderLabel.textColor = .red
            }), completion: nil)
        }
        
        updatePlaceholderFrame()
        placeholderLabel.frame.origin = currentPlaceholderOrigin
        
        UIView.animate(withDuration: 0.4, animations: {
            self.placeholderLabel.font = self.getSmallerFont(from: self.customFont)
            self.placeholderLabel.alpha = 1.0
        })
        
        updateBorderView(isActive: true)
    }
    
    /// Should call in textFieldDidEndEditing
    func animateDidEndEditing() {
        if let text = text, text.isEmpty {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: [], animations: ({
                self.updatePlaceholderFrame()
                self.placeholderLabel.alpha = 1
                self.placeholderLabel.font = self.customFont
                self.placeholderLabel.textColor = self.placeholderColor
            }), completion: { _ in })
            
            updateBorderView(isActive: false)
        }
    }
    
    func updateForValidState(_ isValid: Bool) {
        rightImageView.isHidden = !isValid
    }
    
}

// MARK: - Private Methods
extension CBMFormTextField {
    
    private func updateBorderView(isActive: Bool) {
        borderView.backgroundColor = isActive ? borderActiveColor : borderInactiveColor
    }
    
    private func updatePlaceholder() {
        placeholderLabel.text = placeholderText
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.sizeToFit()
        updatePlaceholderFrame()
        
        if isFirstResponder || !text!.isEmpty {
            animateDidBeginEditing()
        }
    }
    
    private func updatePlaceholderFrame() {
        let textRect = self.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        switch self.textAlignment {
        case .center: originX += textRect.size.width/2 - placeholderLabel.bounds.width/2
        case .right: originX += textRect.size.width - placeholderLabel.bounds.width
        default: break
        }
        placeholderLabel.frame = CGRect(x: originX,
                                        y: textRect.height/2,
                                        width: placeholderLabel.bounds.width,
                                        height: placeholderLabel.bounds.height)
        currentPlaceholderOrigin = CGPoint(x: placeholderLabel.frame.origin.x, y: placeholderLabel.frame.origin.y - placeholderLabel.frame.size.height - placeholderInsets.y)
    }
    
    private func getSmallerFont(from font: UIFont) -> UIFont {
        return UIFont(name: font.fontName, size: font.pointSize * placeholderFontScale) ?? customFont
    }
    
    private func setupRightImageView(with image: UIImage?) {
        //guard let image = image else { return }
        rightImageView.image = image
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.backgroundColor = .red
        self.addSubview(rightImageView)
        rightImageView.anchor(bottom: self.bottomAnchor, right: self.rightAnchor, bottomConstant: 10, widthConstant: 15, heightConstant: 15)
        
        rightPadding = 25
    }
    
    private func setupBorderView() {
        self.addSubview(borderView)
        borderView.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, bottomConstant: 0, heightConstant: borderThickness.inactive)
    }
    
}

