//
//  FinishChargebackVC.swift
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

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

class FinishChargebackVC: UIViewController {

//*************************************************
// MARK: - Properties
//*************************************************
	
	@IBOutlet weak var containerView: UIBox!

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Protected Methods
//*************************************************

	private func containerView(isShow: Bool) {
		
		if isShow {
			
			UIView.animate(withDuration: 0.3,
			               delay: 0.0,
			               usingSpringWithDamping: 0.7,
			               initialSpringVelocity: 0,
			               options: .curveEaseInOut,
			               animations: {
							self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			})
		} else {
			self.containerView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
		}
	}
	
//*************************************************
// MARK: - Exposed Methods
//*************************************************

//*************************************************
// MARK: - Overridden Public Methods
//*************************************************

	override func viewDidLoad() {
		super.viewDidLoad()
		self.containerView(isShow: false)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.containerView(isShow: true)
	}
}

//**********************************************************************************************************
//
// MARK: - Extension -
//
//**********************************************************************************************************
