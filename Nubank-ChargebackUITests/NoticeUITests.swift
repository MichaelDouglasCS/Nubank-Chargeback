//
//  NoticeUITests.swift
//  Nubank-ChargebackUITests
//
//  Created by Michael Douglas on 21/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
//

import XCTest

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

class NoticeUITests: XCTestCase {
	
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
	
	func testShowContainerView_WithDevelopmentEndpoint_ShouldBringTheView() {
		let app = XCUIApplication()
		
		let exists = NSPredicate(format: "hittable == TRUE")
		let noticeViewContainer = app.otherElements["NoticeViewContainer"]
		
		self.expectation(for: exists, evaluatedWith: noticeViewContainer) { () -> Bool in
			return true
		}
		
		self.waitForExpectations(timeout: Test.timeout) { (error) in
			XCTAssertNil(error, "The Notice View Container is Not Showing")
		}
	}

//*************************************************
// MARK: - Overridden Public Methods
//*************************************************
	
    override func setUp() {
        super.setUp()
		
        self.continueAfterFailure = false
        XCUIApplication().launch()
    }
}
