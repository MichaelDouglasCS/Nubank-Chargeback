//
//  ChargebackBO.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 15/09/17.
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

public class ChargebackBO: Mappable {

//*************************************************
// MARK: - Properties
//*************************************************
	
	public var id: String?
	public var title: String?
	public var autoblock: Bool?
	public var reason_details: [ReasonDetailBO] = []
	public var comment_hint: String?
	public var comment: String?

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
		self.autoblock <- map["autoblock"]
		self.reason_details <- map["reason_details"]
		self.comment_hint <- map["comment_hint"]
		self.comment <- map["comment"]
	}
	
	public func toJSON() -> [String : Any] {
		var json: JSON = [:]
		
		if let comment = self.comment {
			json["comment"] = JSON(comment)
		}
		
		if !self.reason_details.isEmpty {
			json["reason_details"] = JSON(self.reason_details.map { $0.toJSON() })
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
