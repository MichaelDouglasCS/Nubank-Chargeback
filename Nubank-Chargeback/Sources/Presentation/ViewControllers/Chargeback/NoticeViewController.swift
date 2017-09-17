//
//  NoticeViewController.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 15/09/17.
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

class NoticeViewController: UIViewController {

//*************************************************
// MARK: - Properties
//*************************************************
	
	@IBOutlet weak var containerView: UIBox!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var contentTextView: UITextView!
	@IBOutlet weak var continueButton: IBDesigableButton!
	@IBOutlet weak var closeButton: UIButton!

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Protected Methods
//*************************************************
	
	private func loadData() {
		self.showActivityIndicator()
		self.containerView(isHidden: true)
		
		NoticeLO.sharedInstance.load() { (result) in
			
			switch result {
			case .success:
				self.updateLayout()
				self.containerView(isHidden: false)
				self.removeActivityIndicator()
			case .error(let error):
				self.showInfoAlert(title: "Sorry! :(", message: error.rawValue)
				break
			}
		}
	}
	
	private func updateLayout() {
		
		if let notice = NoticeLO.sharedInstance.current {
			self.titleLabel.text = notice.title
			self.contentTextView.attributedText = notice.description?.contentHTMLFormatted
			self.continueButton.setTitle(notice.primary_action?.title?.uppercased(), for: .normal)
			self.closeButton.setTitle(notice.secondary_action?.title?.uppercased(), for: .normal)
		}
	}
	
	private func containerView(isHidden: Bool) {
		
		if isHidden {
			self.containerView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
		} else {
			UIView.animate(withDuration: 0.3,
			               delay: 0.0,
			               usingSpringWithDamping: 0.7,
			               initialSpringVelocity: 0,
			               options: .curveEaseInOut,
			               animations: {
							self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			})
		}
	}

//*************************************************
// MARK: - Exposed Methods
//*************************************************
	
	@IBAction func continueAction(_ sender: IBDesigableButton) {
	}

	@IBAction func closeAction(_ sender: UIButton) {
		
	}
	
//*************************************************
// MARK: - Overridden Public Methods
//*************************************************
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.loadData()
    }
	
	deinit {
		NoticeLO.sharedInstance.current = nil
	}
}

//**********************************************************************************************************
//
// MARK: - Extension -
//
//**********************************************************************************************************
