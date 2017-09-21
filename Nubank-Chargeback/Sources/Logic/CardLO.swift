//
//  CardLO.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 21/09/17.
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

public final class CardLO {
	
//*************************************************
// MARK: - Properties
//*************************************************
	
	static public let sharedInstance: CardLO = CardLO()
	
	public var isCardBlocked: Bool = false
	
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
	
	public func blockCard(completionHandler: @escaping LogicResult) {
		ServerRequest.API.blockCard.execute() { (_, result) in
			
			switch result {
			case .success:
				self.isCardBlocked = true
			case .error:
				self.isCardBlocked = false
			}
			completionHandler(result)
		}
	}
	
	public func unblockCard(completionHandler: @escaping LogicResult) {
		ServerRequest.API.unblockCard.execute() { (_, result) in
			
			switch result {
			case .success:
				self.isCardBlocked = false
			case .error:
				self.isCardBlocked = true
			}
			completionHandler(result)
		}
	}
	
//*************************************************
// MARK: - Overridden Public Methods
//*************************************************
	
}
