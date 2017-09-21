//
//  NoticeTests.swift
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

class NoticeTests: XCTestCase {

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
	
	func testNoticeModel_WithNoticeBO_ShouldCreateObject() {
		let notice = NoticeBO()
		
		XCTAssertNotNil(notice, "The Notice Model is nil, should be not nil")
	}
	
	func testActionModel_WithActionBO_ShouldCreateObject() {
		let action = ActionBO()
		
		XCTAssertNotNil(action, "The Action Model is nil, should be not nil")
	}
	
	func testNoticeEndpoint_WithDevelopmentEndpoint_ShouldReturnSuccess() {
		let expectation = self.expectation(description: #function)
		
		NoticeLO.sharedInstance.load() { (result) in
			switch result {
			case .success:
				break
			case .error(let error):
				XCTAssert(false, "The Notice endpoint is returning an error: \(error.rawValue)")
			}
			
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testNoticeResponse_WithDevelopmentEndpoint_ShouldReturnNotice() {
		let expectation = self.expectation(description: #function)
		
		Test.loadNoticeFromAnyServer {
			let notice = NoticeLO.sharedInstance.current
			
			XCTAssertNotNil(notice, "The Notice is nil, the server should return a valid notice")
			
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testNoticeResponse_WithStub_ShouldReturnNotice() {
		let expectation = self.expectation(description: #function)
		let stubManager = StubManager()
		
		stubManager.addStubs()
		
		Test.loadNoticeFromAnyServer {
			let notice = NoticeLO.sharedInstance.current
			
			XCTAssertNotNil(notice, "The Notice is nil, should return a valid notice")
			
			stubManager.removeStubs()
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testNoticeTitleAndDescription_WithStub_ShouldReturnFields() {
		let expectation = self.expectation(description: #function)
		let stubManager = StubManager()
		
		stubManager.addStubs()
		
		Test.loadNoticeFromAnyServer {
			let notice = NoticeLO.sharedInstance.current
			let title = notice?.title ?? ""
			let description = notice?.description ?? ""

			XCTAssertFalse(title.isEmpty, "The Title is Empty, should has a content")
			XCTAssertFalse(description.isEmpty, "The Description is Empty, should has a content")
			
			stubManager.removeStubs()
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
	
	func testNoticeActions_WithStub_ShouldReturnActions() {
		let expectation = self.expectation(description: #function)
		let stubManager = StubManager()
		
		stubManager.addStubs()
		
		Test.loadNoticeFromAnyServer {
			let notice = NoticeLO.sharedInstance.current
			if let primary = notice?.primary_action,
				let secondary = notice?.secondary_action {
				
				XCTAssertFalse(primary.title?.isEmpty ?? true, "The Primary Action Title is Empty, should has a content")
				XCTAssertFalse(secondary.title?.isEmpty ?? true, "The Secondary Action Title is Empty, should has a content")
				XCTAssertFalse(primary.action?.isEmpty ?? true, "The Primary Action is Empty, should has a content")
				XCTAssertFalse(secondary.action?.isEmpty ?? true, "The Secondary Action is Empty, should has a content")
			} else {
				XCTAssert(false, "The Server not returned all actions, should return both")
			}
			
			stubManager.removeStubs()
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}
}

//*************************************************
// MARK: - Overridden Public Methods
//*************************************************
