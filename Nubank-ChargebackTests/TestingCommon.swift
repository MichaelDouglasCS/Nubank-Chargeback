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
	
//**************************************************
// MARK: - Exposed Methods
//**************************************************
	
	static func loadNoticeFromAnyServer(completion: @escaping (() -> Void)) {
		NoticeLO.sharedInstance.current = nil
		NoticeLO.sharedInstance.load { (response: ServerResponse) in
			completion()
		}
	}
	
	static func loadChargebackFromAnyServer(completion: @escaping (() -> Void)) {
		ChargebackLO.sharedInstance.current = nil
		ChargebackLO.sharedInstance.load { (response: ServerResponse) in
			completion()
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
				fileAtPath: OHPathForFile("notice.json", type(of: self)) ?? "",
				statusCode: 200,
				headers: ["Content-Type":"application/json"]
			)
		}
		//Chargeback Stub
		stub(condition: isHost("nu-mobile-hiring.herokuapp.com") && isPath("/chargeback")) { request in
			// Stub it with our "chargeback.json" stub file
			return OHHTTPStubsResponse(
				fileAtPath: OHPathForFile("chargeback.json", type(of: self)) ?? "",
				statusCode: 200,
				headers: ["Content-Type":"application/json"]
			)
		}
	}
	
	func simulateNoInternetConnection() {
		
		stub(condition: isHost("nu-mobile-hiring.herokuapp.com")) { request in
			
			let notConnectedError = NSError(domain:NSURLErrorDomain,
			                                code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue),
			                                userInfo:nil)
			return OHHTTPStubsResponse(error:notConnectedError)
		}
	}
	
	func removeStubs() {
		OHHTTPStubs.removeAllStubs()
	}

//*************************************************
// MARK: - Overridden Public Methods
//*************************************************
	
}
