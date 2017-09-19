//
//  KeyboardKit.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 18/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
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

protocol KeyboardNotifications {
	func keyboardWillShow(notification: Notification)
	func keyboardWillHide(notification: Notification)
}

//**********************************************************************************************************
//
// MARK: - Extension - UIViewController -
//
//**********************************************************************************************************

extension UIViewController {
	
	func keyboardWillChange(notification: Notification) {
		let name = notification.name
		
		if name == .UIKeyboardWillShow {
			(self as? KeyboardNotifications)?.keyboardWillShow(notification: notification)
		} else if name == .UIKeyboardWillHide {
			(self as? KeyboardNotifications)?.keyboardWillHide(notification: notification)
		}
	}
	
	func addKeyboardObservers() {
		NotificationCenter.default.addObserver(self,
		                                       selector: #selector(self.keyboardWillChange(notification:)),
		                                       name: .UIKeyboardWillShow,
		                                       object: nil)
		
		NotificationCenter.default.addObserver(self,
		                                       selector: #selector(self.keyboardWillChange(notification:)),
		                                       name: .UIKeyboardWillHide,
		                                       object: nil)
		
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
		                                                         action: #selector(self.dismissKeyboard))
		self.view.addGestureRecognizer(tap)
	}
	
	func dismissKeyboard() {
		self.view.endEditing(true)
	}
	
	func removeObservers() {
		NotificationCenter.default.removeObserver(self)
		self.view.gestureRecognizers?.removeAll()
	}
}
