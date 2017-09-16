//
//  StyleKit.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 16/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Extension - UIColor
//
//**********************************************************************************************************

extension UIColor {
	
	struct NubankChargeback {
		static var purple: UIColor { return UIColor(hexadecimal: 0x6E2B77) }
	}
	
	convenience init(hexadecimal: Int) {
		let red = CGFloat((hexadecimal >> 16) & 0xff)
		let green = CGFloat((hexadecimal >> 8) & 0xff)
		let blue = CGFloat(hexadecimal & 0xff)
		
		self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
	}
}
