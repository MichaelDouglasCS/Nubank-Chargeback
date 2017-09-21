//
//  NoticeLO.swift
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

public final class NoticeLO {

//*************************************************
// MARK: - Properties
//*************************************************

	static public let sharedInstance: NoticeLO = NoticeLO()
	
	public var current: NoticeBO?
	
//*************************************************
// MARK: - Constructors
//*************************************************

	private init() { }
	
//*************************************************
// MARK: - Protected Methods
//*************************************************

	private func parse(json: JSON) {
		
		if let json = json.dictionaryObject, !json.isEmpty {
			self.current = NoticeBO(JSON: json)
		}
	}
	
//*************************************************
// MARK: - Exposed Methods
//*************************************************
	
	public func load(completionHandler: @escaping LogicResult) {
		ServerRequest.API.notice.execute() { (json, result) in
			DispatchQueue.global().async {
				self.parse(json: json)
				
				DispatchQueue.main.async {
					completionHandler(result)
				}
			}
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
