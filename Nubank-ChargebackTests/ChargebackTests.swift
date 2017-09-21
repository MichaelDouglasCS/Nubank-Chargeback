//
//  ChargebackTests.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 20/09/17.
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
	
	func testChargebackModel_WithChargebackBO_ShouldCreateObject() {
		let chargeback = ChargebackBO()
		
		XCTAssertNotNil(chargeback, "The Chargeback Model is nil, should be not nil")
	}
	
	func testReasonDetailModel_WithReasonDetailBO_ShouldCreateObject() {
		let reasonDetail = ReasonDetailBO()
		
		XCTAssertNotNil(reasonDetail, "The ReasonDetail Model is nil, should be not nil")
	}
	
	func testChargebackEndpoint_WithDevelopmentEndpoint_ShouldReturnSuccess() {
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
	
	func testChargebackResponse_WithDevelopmentEndpoint_ShouldReturnChargeback() {
		let expectation = self.expectation(description: #function)
		
		Test.loadChargebackFromAnyServer {
			let chargeback = ChargebackLO.sharedInstance.current
			
			XCTAssertNotNil(chargeback, "The Chargeback is nil, the server should return a valid Chargeback")
			
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testChargebackResponse_WithStub_ShouldReturnChargeback() {
		let expectation = self.expectation(description: #function)
		let stubManager = StubManager()
		
		stubManager.addStubs()
		
		Test.loadChargebackFromAnyServer {
			let chargeback = ChargebackLO.sharedInstance.current
			
			XCTAssertNotNil(chargeback, "The Chargeback is nil, the server should return a valid Chargeback")
			
			stubManager.removeStubs()
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testChargebackAutoblockTrue_WithStub_ShouldCardBeBlocked() {
		let expectation = self.expectation(description: #function)
		let stubManager = StubManager()
		
		stubManager.addStubs()
		
		Test.loadChargebackFromAnyServer {
			let isCardBlocked = ChargebackLO.sharedInstance.isCardBlocked
			
			XCTAssertTrue(isCardBlocked, "The Card Status is False, Should be True")
			
			stubManager.removeStubs()
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testChargebackFields_WithStub_ShouldReturnAll() {
		let expectation = self.expectation(description: #function)
		let stubManager = StubManager()
		
		stubManager.addStubs()
		
		Test.loadChargebackFromAnyServer {
			let chargeback = ChargebackLO.sharedInstance.current
			
			XCTAssertFalse(chargeback?.id?.isEmpty ?? true, "ID is Empty, Should has content")
			XCTAssertFalse(chargeback?.title?.isEmpty ?? true, "Title is Empty, Should has content")
			XCTAssertNotNil(chargeback?.autoblock, "Autoblock is Nil, Should has content")
			XCTAssertFalse(chargeback?.comment_hint?.isEmpty ?? true, "Comment Hint is Empty, Should has content")
			
			let reasons = chargeback?.reason_details
			
			reasons?.forEach({ (reason) in
				
				XCTAssertFalse(reason.id?.isEmpty ?? true, "Reason id is Empty, Should has content")
				XCTAssertFalse(reason.title?.isEmpty ?? true, "Reason Title is Empty, Should has content")
			})
			
			stubManager.removeStubs()
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}

	func testToJSONChargeback_WithStub_ShouldConvertToJSON() {
		let expectation = self.expectation(description: #function)
		let stubManager = StubManager()
		
		stubManager.addStubs()
		
		Test.loadChargebackFromAnyServer {
			let chargeback = ChargebackLO.sharedInstance.current
			chargeback?.comment = "Some Text"
			
			let params = JSON(chargeback?.toJSON() ?? [:])
			
			XCTAssertNotNil(params["comment"], "The Comment Param not exists, Should exist")
			XCTAssertNotNil(params["reason_details"], "The Reason Details Param not exists, Should exist")
			
			params["reason_details"].forEach({ (_, json) in
				
				XCTAssertNotNil(json["id"], "The Reason ID Param not exists, Should exist")
				XCTAssertNotNil(json["title"], "The Reason Title Param not exists, Should exist")
			})
			
			stubManager.removeStubs()
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testSubmitChargeback_WithStub_ShouldReturnSuccess() {
		let expectation = self.expectation(description: #function)
		let stubManager = StubManager()
		
		stubManager.addStubs()
		
		Test.loadChargebackFromAnyServer {
			let chargeback = ChargebackLO.sharedInstance.current
			chargeback?.comment = "Some Text"
			
			ChargebackLO.sharedInstance.submit() { (result) in
				
				switch result {
				case .success:
					break
				case .error(let error):
					XCTAssertTrue(false, "The Submit was failed, an error occurs: \(error.rawValue)")
				}
			}
			
			stubManager.removeStubs()
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testUpdateReasonDetail_WithTrueResponse_ShouldUpdateResponse() {
		let expectation = self.expectation(description: #function)
		let stubManager = StubManager()
		
		stubManager.addStubs()
		
		Test.loadChargebackFromAnyServer {
			let chargeback = ChargebackLO.sharedInstance.current

			chargeback?.update(reason: .merchant, with: true)
			chargeback?.update(reason: .possession, with: true)
			
			chargeback?.reason_details.forEach({ (reasonDetail) in
				
				if let reason = reasonDetail.reason {
					
					switch reason {
					case .merchant:
						XCTAssertTrue(reasonDetail.response, "The Response is False, Should be True")
					case .possession:
						XCTAssertTrue(reasonDetail.response, "The Response is False, Should be True")
					}
				} else {
					XCTAssertTrue(false, "An Error Ocurred when get Reason")
				}
			})
			
			stubManager.removeStubs()
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testBlockCardEndpoint_WithDevelopmentEndpoint_ShouldReturnSuccess() {
		let expectation = self.expectation(description: #function)
		
		ChargebackLO.sharedInstance.blockCard() { (result) in
			
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
	
	func testUnblockCardEndpoint_WithDevelopmentEndpoint_ShouldReturnSuccess() {
		let expectation = self.expectation(description: #function)
		
		ChargebackLO.sharedInstance.unblockCard() { (result) in
			
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
	
	func testBlockCard_WithDevelopmentEndpoint_ShouldCardBeBlocked() {
		let expectation = self.expectation(description: #function)
		
		ChargebackLO.sharedInstance.blockCard() { _ in
			let isCardBlocked = ChargebackLO.sharedInstance.isCardBlocked
			
			XCTAssertTrue(isCardBlocked, "The Card is Unblocked, Should be Blocked")
			
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testUnblockCard_WithDevelopmentEndpoint_ShouldCardBeUnblocked() {
		let expectation = self.expectation(description: #function)
		
		ChargebackLO.sharedInstance.unblockCard() { _ in
			let isCardBlocked = ChargebackLO.sharedInstance.isCardBlocked
			
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
