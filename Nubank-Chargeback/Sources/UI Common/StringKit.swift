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
	
	private static let defaultOptions: NSRegularExpression.Options = [.caseInsensitive,
	                                                                  .dotMatchesLineSeparators,
	                                                                  .anchorsMatchLines]
	
	var contentHTMLFormatted: NSAttributedString? {
		var text = "<span style=\"font-family:Avenir-Book;font-size:16px;color:#000000;\">\(self)</span>"
		let pattern = "<b>(.*)<\\/b>|<strong>(.*)<\\/strong>"
		
		if let regex = try? NSRegularExpression(pattern: pattern, options: String.defaultOptions) {
			let fullRange = NSRange(location: 0, length: self.characters.count)
			let range = regex.firstMatch(in: self, options: [], range: fullRange)?.range ?? NSRange()
			let nsString = self as NSString
			
			let strongText = nsString.substring(with: range)
			let template = "<span style=\"font-family:Avenir-Heavy;font-size:16px;\">\(strongText)</span>"
			
			text = text.replace(pattern: pattern,
			                    template: template)
		}
		
		guard let stringData = text.data(using: .utf8) else { return nil }
		let options: [String : Any] = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
		                               NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue]
		return try? NSAttributedString(data: stringData, options: options, documentAttributes: nil)
	}
	
	var commentHTMLFormatted: NSAttributedString? {
		var text = "<span style=\"font-family:Avenir-Medium;font-size:16px;color:#999999;\">\(self)</span>"
		let pattern = "<b>(.*)<\\/b>|<strong>(.*)<\\/strong>"
		
		if let regex = try? NSRegularExpression(pattern: pattern, options: String.defaultOptions) {
			let fullRange = NSRange(location: 0, length: self.characters.count)
			let range = regex.firstMatch(in: self, options: [], range: fullRange)?.range ?? NSRange()
			let nsString = self as NSString
			
			let strongText = nsString.substring(with: range)
			let template = "<span style=\"font-family:Avenir-Heavy;font-size:16px;\">\(strongText)</span>"
			
			text = text.replace(pattern: pattern,
			                    template: template)
		}
		
		guard let stringData = text.data(using: .utf8) else { return nil }
		let options: [String : Any] = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
		                               NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue]
		return try? NSAttributedString(data: stringData, options: options, documentAttributes: nil)
	}
	
	public func replace(pattern: String, template: String) -> String {
		var result = self
		
		if let regex = try? NSRegularExpression(pattern: pattern, options: String.defaultOptions) {
			let fullRange = NSRange(location: 0, length: self.characters.count)
			
			result = regex.stringByReplacingMatches(in: self,
			                                        options: [],
			                                        range: fullRange,
			                                        withTemplate: template)
		}
		
		return result
	}
}
