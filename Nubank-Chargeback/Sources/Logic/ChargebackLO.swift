//
//  ChargebackLO.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 15/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
//

import Foundation
import SwiftyJSON

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
	public var isCardBlocked: Bool = false
	
//*************************************************
// MARK: - Constructors
//*************************************************

	private init() { }
	
//*************************************************
// MARK: - Protected Methods
//*************************************************
	
	private func parse(json: JSON) {
		
		if let json = json.dictionaryObject {
			self.current = ChargebackBO(JSON: json)
		}
	}

//*************************************************
// MARK: - Exposed Methods
//*************************************************
	
	public func load(completionHandler: @escaping LogicResult) {
		ServerRequest.API.chargeback.execute() { (json, result) in
			DispatchQueue.global().async {
				self.parse(json: json)
				
				if self.current?.autoblock ?? false {
					
					self.blockCard() { (result) in
						DispatchQueue.main.async {
							completionHandler(result)
						}
					}
				} else {
					DispatchQueue.main.async {
						completionHandler(result)
					}
				}
			}
		}
	}
	
	public func submit(completionHandler: @escaping LogicResult) {
		
		if let params = self.current?.toJSON() {
			ServerRequest.API.sendChargeback.execute(params: params) { (_, result) in
				completionHandler(result)
			}
		}
	}
	
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

//**********************************************************************************************************
//
// MARK: - Extension - ChargebackBO
//
//**********************************************************************************************************

extension ChargebackBO {
	
	func update(reason received: ReasonDetailBO.Reason, with response: Bool) {
		
		self.reason_details.forEach({ (reason) in
			
			switch received {
			case .merchant:
				reason.response = response
			case .possession:
				reason.response = response
			}
		})
	}
}
