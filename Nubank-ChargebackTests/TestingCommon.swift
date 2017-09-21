//
//  TestingCommon.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 20/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
//

import XCTest
import OHHTTPStubs
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
	
	static func loadNoticeFromAnyServer(completion: @escaping (() -> Void)) {
		if self.isLoadedNotice {
			completion()
		} else {
			NoticeLO.sharedInstance.load { (response: ServerResponse) in
				self.isLoadedNotice = true
				completion()
			}
		}
	}
	
	static func loadChargebackFromAnyServer(completion: @escaping (() -> Void)) {
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

class StubManager {
	
//*************************************************
// MARK: - Properties
//*************************************************

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Protected Methods
//*************************************************

//*************************************************
// MARK: - Exposed Methods
//*************************************************
	
	func addStubs() {
		//Notice Stub
		stub(condition: isHost("nu-mobile-hiring.herokuapp.com") && isPath("/notice")) { request in
			// Stub it with our "notice.json" stub file
			return OHHTTPStubsResponse(
				fileAtPath: OHPathForFile("notice.json", type(of: self))!,
				statusCode: 200,
				headers: ["Content-Type":"application/json"]
			)
		}
		//Chargeback Stub
		stub(condition: isHost("nu-mobile-hiring.herokuapp.com") && isPath("/chargeback")) { request in
			// Stub it with our "chargeback.json" stub file
			return OHHTTPStubsResponse(
				fileAtPath: OHPathForFile("chargeback.json", type(of: self))!,
				statusCode: 200,
				headers: ["Content-Type":"application/json"]
			)
		}
	}
	
	func removeStubs() {
		OHHTTPStubs.removeAllStubs()
	}

//*************************************************
// MARK: - Overridden Public Methods
//*************************************************
	
}
