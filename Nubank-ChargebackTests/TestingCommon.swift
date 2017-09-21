//
//  TestingCommon.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 20/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
//

import XCTest
@testable import Nubank_Chargeback

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
// MARK: - Type -
//
//**********************************************************************************************************

struct Test {
	
//**************************************************
// MARK: - Properties
//**************************************************
	
	static let timeout: TimeInterval = 30.0
	static var isLoadedNotice: Bool = false
	static var isLoadedChargeback: Bool = false
	
//**************************************************
// MARK: - Exposed Methods
//**************************************************
	
	static func loadNoticeFromServer(completion: @escaping (() -> Void)) {
		if self.isLoadedNotice {
			completion()
		} else {
			NoticeLO.sharedInstance.load { (response: ServerResponse) in
				self.isLoadedNotice = true
				completion()
			}
		}
	}
	
	static func loadChargebackFromServer(completion: @escaping (() -> Void)) {
		if self.isLoadedChargeback {
			completion()
		} else {
			ChargebackLO.sharedInstance.load { (response: ServerResponse) in
				self.isLoadedChargeback = true
				completion()
			}
		}
	}
}
