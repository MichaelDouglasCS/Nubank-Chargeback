//
//  ReasonDetailBO.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 16/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
//

import Foundation
import ObjectMapper
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

public class ReasonDetailBO: Mappable {

	public enum Reason: String {
		case merchant = "merchant_recognized"
		case possession = "card_in_possession"
	}
	
//*************************************************
// MARK: - Properties
//*************************************************

	public var id: String?
	public var title: String?
	public var response: Bool = false
	
//*************************************************
// MARK: - Constructors
//*************************************************
	
	public required init() { }
	
	public required init?(map: Map) { }

//*************************************************
// MARK: - Protected Methods
//*************************************************

//*************************************************
// MARK: - Exposed Methods
//*************************************************
	
	public func mapping(map: Map) {
		self.id <- map["id"]
		self.title <- map["title"]
		self.response <- map["response"]
	}
	
	public func toJSON() -> [String : Any] {
		
		var json: JSON = [:]
		
		if let id = self.id {
			json["id"] = JSON(id)
			json["response"] = JSON(self.response)
		}
		
		return json.dictionaryObject ?? [:]
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

extension ReasonDetailBO {
	
	var reason: ReasonDetailBO.Reason? {
		let reason = self.id ?? ""
		return Reason(rawValue: reason)
	}
}
