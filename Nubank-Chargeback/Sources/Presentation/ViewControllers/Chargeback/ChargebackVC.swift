//
//  ChargebackVC.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 17/09/17.
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

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

class ChargebackVC: UIViewController {

//*************************************************
// MARK: - Properties
//*************************************************
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var padlockView: UIStackView!
	@IBOutlet weak var cardStatusView: UIImageView!
	@IBOutlet weak var cardStatusLabel: UILabel!
	@IBOutlet weak var merchantLabel: UILabel!
	@IBOutlet weak var merchantSwitch: UISwitchButton!
	@IBOutlet weak var possessionLabel: UILabel!
	@IBOutlet weak var possessionSwitch: UISwitchButton!
	@IBOutlet weak var commentTextView: UITextView!
	@IBOutlet weak var contestButton: UIButton!
	@IBOutlet weak var footerConstraint: NSLayoutConstraint!
	
	var canContest: Bool = false {
		didSet {
			self.contestButton.isEnabled = self.canContest
		}
	}

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Protected Methods
//*************************************************
	
	private func updateLayout() {
		
		if let chargeback = ChargebackLO.sharedInstance.current {
			self.titleLabel.text = chargeback.title?.uppercased()
			self.updatePadlockLayout()
			
			if let merchant = chargeback.reason_details.filter({ $0.reason == .merchant }).first,
			   let possession = chargeback.reason_details.filter({ $0.reason == .possession }).first {
				self.merchantLabel.text = merchant.title
				self.possessionLabel.text = possession.title
			}
			self.commentTextView.attributedText = chargeback.comment_hint?.commentHTMLFormatted
		}
	}
	
	private func updatePadlockLayout() {
		let isCardBlocked = ChargebackLO.sharedInstance.isCardBlocked ?? false
		
		if isCardBlocked {
			self.cardStatusView.image = UIImage(named: "icon_chargeback_lock")
			self.cardStatusLabel.text = "Bloqueamos preventivamente o seu cartão."
		} else {
			self.cardStatusView.image = UIImage(named: "icon_chargeback_unlock")
			self.cardStatusLabel.text = "Cartão desbloqueado, recomendamos mantê-lo bloqueado."
		}
	}
	
	private func loadingPadlock(inProgress: Bool) {
		typealias color = UIColor.NubankChargeback
		
		self.cardStatusView.loadingIndicatorView(isShow: inProgress, with: color.purple)
	}
	
	@objc private func padlockDidTap() {
		let isCardBlocked = ChargebackLO.sharedInstance.isCardBlocked ?? false
		
		self.loadingPadlock(inProgress: true)
		
		if isCardBlocked {
			
			ChargebackLO.sharedInstance.unblockCard() { (result) in
				
				switch result {
				case .success:
					self.updatePadlockLayout()
				case .error(let error):
					self.showInfoAlert(title: "Sorry! :(", message: error.rawValue)
				}
				self.loadingPadlock(inProgress: false)
			}
		} else {
			ChargebackLO.sharedInstance.blockCard() { (result) in
				
				switch result {
				case .success:
					self.updatePadlockLayout()
				case .error(let error):
					self.showInfoAlert(title: "Sorry! :(", message: error.rawValue)
				}
				self.loadingPadlock(inProgress: false)
			}
		}
	}
	
	private func loadingContestButton(isShow: Bool) {
		typealias color = UIColor.NubankChargeback
		let view = self.contestButton.titleLabel
		let x = (view?.frame.maxX ?? 0.0) + 15.0
		let point = CGPoint(x: x, y: view?.center.y ?? 0.0)
		
		if isShow {
			self.contestButton.loadingIndicatorView(isShow: true, with: color.purple, at: point)
			self.contestButton.isEnabled = false
		} else {
			self.contestButton.loadingIndicatorView(isShow: false)
			self.contestButton.isEnabled = true
		}
	}

//*************************************************
// MARK: - Exposed Methods
//*************************************************
	
	@IBAction func switchAction(_ sender: UISwitchButton) {
		typealias color = UIColor.NubankChargeback
		sender.isOn = sender.isOn ? false : true
		
		switch sender {
		case self.merchantSwitch:
			self.merchantLabel.textColor = sender.isOn ? color.green : color.black
			ChargebackLO.sharedInstance.current?.update(reason: .merchant, with: sender.isOn)
		case self.possessionSwitch:
			self.possessionLabel.textColor = sender.isOn ? color.green : color.black
			ChargebackLO.sharedInstance.current?.update(reason: .possession, with: sender.isOn)
		default: break
		}
	}

	@IBAction func cancelAction(_ sender: UIButton) {
		self.navigationController?.popViewController(animated: true)
	}
	
	@IBAction func contestAction(_ sender: UIButton) {
		self.loadingContestButton(isShow: true)
		
		ChargebackLO.sharedInstance.submit() { (result) in
			
			switch result {
			case .success:
				DispatchQueue.main.async {
					self.performSegue(withIdentifier: "showFinishChargeback", sender: nil)
				}
			case .error(let error):
				self.showInfoAlert(title: "Sorry! :(", message: error.rawValue)
			}
			self.loadingContestButton(isShow: false)
		}
	}
	
//*************************************************
// MARK: - Overridden Public Methods
//*************************************************
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.updateLayout()
		self.addKeyboardObservers()
		
		let padlockTapping = UITapGestureRecognizer(target: self,
		                                            action: #selector(self.padlockDidTap))
		self.padlockView.addGestureRecognizer(padlockTapping)
	}
	
	deinit {
		self.removeObservers()
	}
}

//**********************************************************************************************************
//
// MARK: - Extension - UITextViewDelegate
//
//**********************************************************************************************************

extension ChargebackVC: UITextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		
		if let commentHint = ChargebackLO.sharedInstance.current?.comment_hint {
			
			if textView.text == commentHint.clearHTML {
				textView.text = ""
			}
		}
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		
		if let commentHint = ChargebackLO.sharedInstance.current?.comment_hint {

			if textView.text.isEmpty {
				textView.attributedText = commentHint.commentHTMLFormatted
			}
		}
	}
	
	func textViewDidChange(_ textView: UITextView) {
		let isEmpty = textView.text.isEmpty
		
		self.canContest = !isEmpty
		ChargebackLO.sharedInstance.current?.comment = isEmpty ? "" : textView.text
	}
}

//**********************************************************************************************************
//
// MARK: - Extension - Keyboard
//
//**********************************************************************************************************

extension ChargebackVC: KeyboardNotifications {
	
	func adjustingHeight(show: Bool, notification: Notification) {
		
		if let userInfo = notification.userInfo,
		   let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
		   let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
			let changeInHeight = (keyboardRect.height) * (show ? 1 : -1)
			
			UIView.animate(withDuration: animationDuration, animations: {
				self.footerConstraint.constant += changeInHeight
			})
		}
	}
	
	func keyboardWillShow(notification: Notification) {
		self.adjustingHeight(show: true, notification: notification)
	}
	
	func keyboardWillHide(notification: Notification) {
		self.adjustingHeight(show: false, notification: notification)
	}
}
