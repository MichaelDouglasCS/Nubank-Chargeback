//
//  AlertKit.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 17/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Extension - UIViewController
//
//**********************************************************************************************************

extension UIViewController {
	
//**************************************************
// MARK: - Protected Methods
//**************************************************
	
	private static func generateAlert(for title: String, message: Any) -> UIAlertController {
		let attMsg = message as? NSAttributedString
		let stringMsg = message as? String ?? ""
		let alert = UIAlertController(title: title, message: stringMsg, preferredStyle: .alert)
		
		if let attributed = attMsg {
			alert.setValue(attributed, forKey: "attributedMessage")
		}
		
		return alert
	}

//*************************************************
// MARK: - Exposed Methods
//*************************************************
	
	func showInfoAlert(title: String, message: Any, completion: ((UIAlertAction) -> Void)? = nil) {
		let alert = UIViewController.generateAlert(for: title, message: message)
		let defaultAction = UIAlertAction(title: "OK", style: .default, handler: completion)
		
		alert.addAction(defaultAction)
		self.present(alert, animated: true, completion: nil)
	}

	func showActivityIndicator(activityColor color: UIColor = UIColor.white) {
		let activityStyle = UIActivityIndicatorViewStyle.whiteLarge
		let activity = UIActivityIndicatorView(activityIndicatorStyle: activityStyle)
		
		activity.color = color
		activity.center = self.view.center
		
		self.view.addSubview(activity)
		activity.startAnimating()
	}
	
	func removeActivityIndicator() {
		self.view.subviews.forEach({
			
			if let activity = $0 as? UIActivityIndicatorView {
				activity.removeFromSuperview()
			}
		})
	}
}

//**********************************************************************************************************
//
// MARK: - Extension - UIView
//
//**********************************************************************************************************

extension UIView {
	
	func loadingIndicatorView(isShow: Bool, with color: UIColor = UIColor.white, at point: CGPoint? = nil) {
		
		if isShow {
			let activityStyle = UIActivityIndicatorViewStyle.white
			let activity = UIActivityIndicatorView(activityIndicatorStyle: activityStyle)
			let viewHeight = self.frame.height
			let viewWidth = self.frame.width
			
			activity.color = color
			activity.center = CGPoint(x: point?.x ?? (viewWidth/2), y: point?.y ?? (viewHeight/2))
			
			self.addSubview(activity)
			activity.startAnimating()
		} else {
			self.subviews.forEach({
				
				if let activity = $0 as? UIActivityIndicatorView {
					activity.removeFromSuperview()
				}
			})
		}
	}
}
