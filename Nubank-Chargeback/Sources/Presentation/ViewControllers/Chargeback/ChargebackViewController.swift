//
//  ChargebackViewController.swift
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

class ChargebackViewController: UIViewController {

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

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Protected Methods
//*************************************************
	
	private func loadData() {
		
		ChargebackLO.sharedInstance.load() { (result) in
			
			switch result {
			case .success:
				self.updateLayout()
			case .error(let error):
				self.showInfoAlert(title: "Sorry! :(", message: error.rawValue)
				break
			}
		}
	}
	
	private func updateLayout() {
		
		if let chargeback = ChargebackLO.sharedInstance.current {
			self.titleLabel.text = chargeback.title?.uppercased()
			
			if let merchant = chargeback.reason_details.filter({ $0.reason == .merchant }).first,
			   let possession = chargeback.reason_details.filter({ $0.reason == .possession }).first {
				self.merchantLabel.text = merchant.title
				self.possessionLabel.text = possession.title
			}
			
			self.commentTextView.attributedText = chargeback.comment_hint?.commentHTMLFormatted
		}
	}
	
	private func card(isBlocked: Bool) {
		
		if isBlocked {
			self.cardStatusView.image = UIImage(named: "icon_chargeback_lock")
			self.cardStatusLabel.text = "Bloqueamos preventivamente o seu cartão"
		} else {
			self.cardStatusView.image = UIImage(named: "icon_chargeback_unlock")
			self.cardStatusLabel.text = "Cartão desbloqueado, recomendamos mantê-lo bloqueado"
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
		case self.possessionSwitch:
			self.possessionLabel.textColor = sender.isOn ? color.green : color.black
		default: break
		}
	}

	@IBAction func cancelAction(_ sender: UIButton) {
		self.navigationController?.popViewController(animated: true)
	}
	
	@IBAction func contestAction(_ sender: UIButton) {
	}
	
//*************************************************
// MARK: - Overridden Public Methods
//*************************************************
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.loadData()
	}
}

//**********************************************************************************************************
//
// MARK: - Extension -
//
//**********************************************************************************************************
