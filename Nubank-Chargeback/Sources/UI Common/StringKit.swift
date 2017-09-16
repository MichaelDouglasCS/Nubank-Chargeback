//
//  StringKit.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 16/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Extension -
//
//**********************************************************************************************************

extension String{
	
	func convertHTML() -> NSAttributedString {
		guard let data = data(using: .utf8) else { return NSAttributedString() }
		let options: [String: Any] = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
		                              NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue]

		do {
			let attributed = try NSAttributedString(data: data,
			                                        options: options,
			                                        documentAttributes: nil)
			
			return attributed
		} catch {
			return NSAttributedString()
		}
	}
}
