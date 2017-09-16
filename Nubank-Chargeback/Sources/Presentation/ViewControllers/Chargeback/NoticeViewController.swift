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
		
		NoticeLO.sharedInstance.load() { (result) in
			
			switch result {
			case .success:
				self.updateLayout()
			case .error(let error): break
			}
		}
	}
	
	private func updateLayout() {
		if let notice = NoticeLO.sharedInstance.current {
			self.titleLabel.text = notice.title
			self.contentTextView.attributedText = notice.description?.convertHTML()
			self.contentTextView.font = UIFont(name: "Avenir-Book", size: 16.0)
			self.continueButton.setTitle(notice.primary_action?.title, for: .normal)
			self.closeButton.setTitle(notice.secondary_action?.title, for: .normal)
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
