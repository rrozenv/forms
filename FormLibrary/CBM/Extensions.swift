//
//  Extensions.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/27/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    static func findFirstTextField(in view: UIView)-> UITextField? {
        return view.subviews.compactMap { (view) -> UITextField? in
            if view is UITextField { return view as? UITextField }
            else { return UIView.findFirstTextField(in: view) }
        }
        .first
    }
}

extension String {
    
    mutating func phoneRepresentable() -> String {
        guard self != "" else { return "" }
        var finalString = NSString()
        let phoneNumberString: NSMutableString = NSMutableString(string: self)
        if self.count < 3 && self.range(of: "(") == nil {
            phoneNumberString.insert("(", at: 0)
        } else if self.count == 4 {
            phoneNumberString.insert(")", at: 4)
        } else if self.count == 6 {
            phoneNumberString.insert(" ", at: 5)
        } else if self.count == 10 && self.range(of: "-") == nil {
            phoneNumberString.insert("-", at: 9)
        }
        finalString = phoneNumberString
        return finalString as String
    }
    
    var digitsOnly: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
}

extension UIView {
    
    public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
    
}

extension UIViewController {
    override open func touchesBegan(_ touches: Set<UITouch>,
                                    with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UIViewController {
    
    func addChild(_ viewController: UIViewController, frame: CGRect? = nil, animated: Bool = false, belowView: UIView? = nil) {
        self.addChildViewController(viewController)
        if let belowView = belowView {
            self.view.insertSubview(viewController.view, belowSubview: belowView)
        } else {
            self.view.addSubview(viewController.view)
        }
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        if let frame = frame { viewController.view.frame = frame }
        
        guard animated else { view.alpha = 1.0; return }
        UIView.transition(with: view, duration: 0.5, options: .curveEaseIn, animations: {
            self.view.alpha = 1.0
        }) { _ in }
    }
    
    func removeChild(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
        if completion != nil { completion!() }
    }
    
}
