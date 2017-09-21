//
//  CardTests.swift
//  Nubank-ChargebackTests
//
//  Created by Michael Douglas on 21/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
//

import XCTest
import SwiftyJSON
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

class CardTests: XCTestCase {
	
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

	func testBlockCardEndpoint_WithDevelopmentEndpoint_ShouldReturnSuccess() {
		let expectation = self.expectation(description: #function)
		
		CardLO.sharedInstance.blockCard() { (result) in
			
			switch result {
			case .success:
				break
			case .error(let error):
				XCTAssert(false, "The Block Card endpoint is returning an error: \(error.rawValue)")
			}
			
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testBlockCardEndpoint_WithDevelopmentEndpoint_ShouldReturnError() {
		let expectation = self.expectation(description: #function)
		let stubManager = StubManager()
		
		stubManager.simulateNoInternetConnection()
		
		CardLO.sharedInstance.blockCard() { (result) in
			
			switch result {
			case .success:
				XCTAssert(false, "The Block Card endpoint is not Handling Error")
			case .error:
				break
			}
			
			stubManager.removeStubs()
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testUnblockCardEndpoint_WithDevelopmentEndpoint_ShouldReturnSuccess() {
		let expectation = self.expectation(description: #function)
		
		CardLO.sharedInstance.unblockCard() { (result) in
			
			switch result {
			case .success:
				break
			case .error(let error):
				XCTAssert(false, "The Unblock Card endpoint is returning an error: \(error.rawValue)")
			}
			
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testUnblockCardEndpoint_WithDevelopmentEndpoint_ShouldReturnError() {
		let expectation = self.expectation(description: #function)
		let stubManager = StubManager()
		
		stubManager.simulateNoInternetConnection()
		
		CardLO.sharedInstance.unblockCard() { (result) in
			
			switch result {
			case .success:
				XCTAssert(false, "The Unblock Card endpoint is not Handling Erro")
			case .error:
				break
			}
			
			stubManager.removeStubs()
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testBlockCard_WithDevelopmentEndpoint_ShouldCardBeBlocked() {
		let expectation = self.expectation(description: #function)
		
		CardLO.sharedInstance.blockCard() { _ in
			let isCardBlocked = CardLO.sharedInstance.isCardBlocked
			
			XCTAssertTrue(isCardBlocked, "The Card is Unblocked, Should be Blocked")
			
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testUnblockCard_WithDevelopmentEndpoint_ShouldCardBeUnblocked() {
		let expectation = self.expectation(description: #function)
		
		CardLO.sharedInstance.unblockCard() { _ in
			let isCardBlocked = CardLO.sharedInstance.isCardBlocked
			
			XCTAssertFalse(isCardBlocked, "The Card is Blocked, Should be Unblocked")
			
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

