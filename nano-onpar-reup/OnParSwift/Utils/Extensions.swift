//
//  Extensions+UIView.swift
//  SlideOutMenuInProgress
//  An anchor extension file that will help us do our jobs a lot easier
//  Created by Brian Voong on 9/30/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainBackgroundGrey() -> UIColor {
        return UIColor.rgb(red: 246, green: 247, blue: 248)
    }
    
}

extension UILabel {

    func addBetweenlineSpacing(spacingValue: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        // Check if there's any text
        guard let textString = text else { return }
        let attributedString = NSMutableAttributedString(string: textString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacingValue
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        // Adding ParagraphStyle to your attributed String
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))

        self.attributedText = attributedString
    }

}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIViewController {
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
extension CALayer {
func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

    let border = CALayer()

    switch edge {
    case .top:
        border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
    case .bottom:
        border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
    case .left:
        border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
    case .right:
        border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
    default:
        break
    }
    border.backgroundColor = color.cgColor
    addSublayer(border)
    }
}


extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    @discardableResult
       func anchor2(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
           
           translatesAutoresizingMaskIntoConstraints = false
           var anchoredConstraints = AnchoredConstraints()
           
           if let top = top {
               anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
           }
           
           if let leading = leading {
               anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
           }
           
           if let bottom = bottom {
               anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
           }
           
           if let trailing = trailing {
               anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
           }
           
           if size.width != 0 {
               anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
           }
           
           if size.height != 0 {
               anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
           }
           
           [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
           
           return anchoredConstraints
       }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    
    
    @discardableResult
    open func withHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    open func withWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    
}
    
    

