//
//  ChargebackLO.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 15/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
//

import Foundation

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

public final class ChargebackLO {

//*************************************************
// MARK: - Properties
//*************************************************

	static public let sharedInstance: ChargebackLO = ChargebackLO()
	
	public var current: ChargebackBO?
	public var cardIsBlocked: Bool?
	
//*************************************************
// MARK: - Constructors
//*************************************************

	private init() { }
	
//*************************************************
// MARK: - Protected Methods
//*************************************************

//*************************************************
// MARK: - Exposed Methods
//*************************************************
	
	public func load(completionHandler: @escaping LogicResult) {
		ServerRequest.API.chargeback.execute() { (json, result) in
			
			if let json = json.dictionaryObject {
				self.current = ChargebackBO(JSON: json)
			}
			completionHandler(result)
		}
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
