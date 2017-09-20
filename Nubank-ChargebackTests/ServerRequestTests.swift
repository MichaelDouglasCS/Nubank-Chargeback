//
//  ServerRequestTests.swift
//  Nubank-ChargebackTests
//
//  Created by Michael Douglas on 14/09/17.
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

class ServerRequestTests: XCTestCase {
	
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
	
	func testServerRequest_WithCustomURLPath_ShouldReplaceParams() {
		let serverRequest = ServerRequest.mobile((method: .get, path: "path/{param1}/{second}/{var3}"))
		let url = serverRequest.url(params: "A", "B", "c")
		
		XCTAssertNotNil(url, "The url is not being initialized")
		
		if let finalURL = url {
			let string = finalURL.absoluteString
			
			XCTAssert(string.contains("A"), "The url first param is not being replaced")
			XCTAssert(string.contains("B"), "The url second param is not being replaced")
			XCTAssert(string.contains("c"), "The url third param is not being replaced")
			XCTAssert(!string.contains("{param1}"), "The url first param is not being replaced")
			XCTAssert(!string.contains("{second}"), "The url second param is not being replaced")
			XCTAssert(!string.contains("{var3}"), "The url third param is not being replaced")
		}
	}
	
	func testServerRequest_WithExternalQuickConnectionToGoogle_ShouldSucceed() {
		let expectation = self.expectation(description: #function)
		
		ServerRequest.mobile((method: .get, path: "/")).execute(aPath: "https://google.com") { (json, response) in
			switch response {
			case .success:
				break
			default:
				XCTAssert(false, "The server response should be successfull if there is connection")
			}
			
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: Test.timeout, handler: nil)
	}

//*************************************************
// MARK: - Overridden Public Methods
//*************************************************
    
}
