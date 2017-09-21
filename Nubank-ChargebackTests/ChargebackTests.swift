//
//  ChargebackTests.swift
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
// MARK: - Class -
//
//**********************************************************************************************************

class ChargebackTests: XCTestCase {

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
	
	func testChargeback_WithChargebackBOModel_ShouldCreateObject() {
		let chargeback = ChargebackBO()
		
		XCTAssertNotNil(chargeback, "The Chargeback Model is nil, should be not nil")
	}
	
	func testChargeback_WithDevelopmentEndpoint_ShouldReturnSuccess() {
		let expectation = self.expectation(description: #function)
		
		ChargebackLO.sharedInstance.load() { (result) in
			switch result {
			case .success:
				break
			case .error(let error):
				XCTAssert(false, "The Chargeback endpoint is returning an error: \(error.rawValue)")
			}
			
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testChargeback_WithDevelopmentEndpoint_ShouldReturnChargeback() {
		let expectation = self.expectation(description: #function)
		
		Test.loadChargebackFromServer {
			let chargeback = ChargebackLO.sharedInstance.current
			
			XCTAssertNotNil(chargeback, "The Chargeback is nil, the server should return a valid Chargeback")
			
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}

//*************************************************
// MARK: - Overridden Public Methods
//*************************************************

}

//**********************************************************************************************************
//
// MARK: - Extension -
//
//**********************************************************************************************************
