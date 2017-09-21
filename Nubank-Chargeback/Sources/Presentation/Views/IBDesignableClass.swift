//
//  IBDesignableClass.swift
//  Confidant
//
//  Created by Michael Douglas on 1/04/16.
//  Copyright © 2016 Michael Douglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Constants -
//
//**********************************************************************************************************

//**********************************************************************************************************
//
// MARK: - Definitions -
//
//**********************************************************************************************************

//**********************************************************************************************************
//
// MARK: - IBDesignable Classes
//
//**********************************************************************************************************

//*************************************************
// MARK: - UIView
//*************************************************

@IBDesignable
class IBDesigableView: UIView {
    
//**************************************************
// MARK: - Properties
//**************************************************
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
	
//*************************************************
// MARK: - Override Public Methods
//*************************************************
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
}

//*************************************************
// MARK: - UIImageView
//*************************************************

@IBDesignable
class IBDesigableImageView: UIImageView {
    
//**************************************************
// MARK: - Properties
//**************************************************
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
	
//*************************************************
// MARK: - Override Public Methods
//*************************************************
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
}

//*************************************************
// MARK: - UIButton
//*************************************************

@IBDesignable
class IBDesigableButton: UIButton {
    
//**************************************************
// MARK: - Properties
//**************************************************
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
	
//*************************************************
// MARK: - Protected Methods
//*************************************************
	
	private func setupView() {
		
	}
	
//*************************************************
// MARK: - Override Public Methods
//*************************************************
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		self.setupView()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.setupView()
	}
}

//*************************************************
// MARK: - UITextField
//*************************************************

@IBDesignable
class IBDesigableTextField: UITextField {
    
//**************************************************
// MARK: - Properties
//**************************************************
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
	
//*************************************************
// MARK: - Override Public Methods
//*************************************************
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
}

//*************************************************
// MARK: - UILabel
//*************************************************

@IBDesignable
class IBDesigableLabel: UILabel {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    @IBInspectable var letterSpacing: CGFloat = 0 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(NSAttributedStringKey.font, value: self.font!, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: self.textColor!, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }
    }
    
    @IBInspectable var lineSpace: CGFloat = 0 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = self.textAlignment
            paragraphStyle.lineSpacing = lineSpace
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(NSAttributedStringKey.font, value: self.font!, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: self.textColor!, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString;
        }
    }
	
//*************************************************
// MARK: - Override Public Methods
//*************************************************
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
}

//*************************************************
// MARK: - UINavigationBar
//*************************************************

@IBDesignable
class IBDesignableNavigationBar: UINavigationBar {
    
//**************************************************
// MARK: - Properties
//**************************************************
    
    @IBInspectable var navigationHeigh: CGFloat = 44 {
        didSet {
            self.frame.size.height = navigationHeigh
        }
    }
    
    @IBInspectable var backgroundImage: UIImage? {
        didSet{
            self.setBackgroundImage(backgroundImage, for: .default)
        }
    }
	
//*************************************************
// MARK: - Override Public Methods
//*************************************************
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
}
