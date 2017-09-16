//
//  ServerRequest.swift
//  Nubank-Chargeback
//
//  Created by Michael Douglas on 14/09/17.
//  Copyright © 2017 MichaelDouglas. All rights reserved.
//

import Foundation
import Alamofire
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

public typealias LogicResult = (ServerResponse) -> Void
public typealias ServerResult = (JSON, ServerResponse) -> Void

/**
Defines how the main server defines its responses.
Showing up the agreed error codes and messages for each of the known scenarios.
*/
public enum ServerResponse {
	
	public enum Error: String {
		case unkown = "Server Error!"
	}
	
	case success
	case error(ServerResponse.Error)
	
//**************************************************
// MARK: - Properties
//**************************************************
	
	public var localizedError: String {
		switch self {
		case .error(let type):
			return type.rawValue
		default:
			return ""
		}
	}
	
//**************************************************
// MARK: - Constructors
//**************************************************
	
	public init(_ response: HTTPURLResponse?) {
		if let httpResponse = response {
			switch httpResponse.statusCode {
			case 200..<300:
				self = .success
			default:
				self = .error(.unkown)
			}
		} else {
			self = .error(.unkown)
		}
	}
}

//**********************************************************************************************************
//
// MARK: - Type -
//
//**********************************************************************************************************

public enum ServerRequest {
	
	case mobile(RESTContract)
	
	public typealias RESTContract = (method: HTTPMethod, path: String)
	
	public struct Domain {
		static public var mobile: String = Domain.develop
		
		static public let develop: String = "https://nu-mobile-hiring.herokuapp.com"
	}
	
	public struct API {
		static public let notice: ServerRequest = .mobile((method: .get, path: "/notice"))
		static public let chargeback: ServerRequest = .mobile((method: .get, path: "/chargeback"))
		static public let sendChargeback: ServerRequest = .mobile((method: .post, path: "/chargeback"))
		static public let blockCard: ServerRequest = .mobile((method: .post, path: "/card_block"))
		static public let unblockCard: ServerRequest = .mobile((method: .post, path: "/card_unblock"))
	}
	
//**************************************************
// MARK: - Protected Methods
//**************************************************

//**************************************************
// MARK: - Exposed Methods
//**************************************************
	
	public var method: HTTPMethod {
		switch self {
		case .mobile(let contract):
			return contract.method
		}
	}
	
	public var path: String {
		switch self {
		case .mobile(let contract):
			return ServerRequest.Domain.mobile + contract.path
		}
	}
	
	public func url(params: String...) -> URL? {
		let path = self.path
		let fullRange = NSRange(location: 0, length: path.characters.count)
		let template = "==##=="
		
		if let regex = try? NSRegularExpression(pattern: "\\{.*?\\}", options: []) {
			let clean = regex.stringByReplacingMatches(in: path,
			                                           options: [],
			                                           range: fullRange,
			                                           withTemplate: template)
			var components = clean.components(separatedBy: template)
			var index = 1
			
			params.forEach {
				if components.count > index {
					components.insert($0, at: index)
					index += 2
				}
			}
			
			return URL(string: components.joined())
		}
		
		return nil
	}
	
	public func execute(aPath: String? = nil,
	                    params: [String: Any]? = nil,
	                    headers: HTTPHeaders? = nil,
	                    completion: @escaping ServerResult) {
		DispatchQueue.global(qos: .background).async {
			
			let method = self.method
			let finalPath = aPath ?? self.path
			let closure = { (_ dataResponse: DataResponse<Any>) in
				
				var json: JSON = [:]
				let httpResponse = dataResponse.response
        
				switch dataResponse.result {
				case .success(let data):
					json = JSON(data)
				default:
					break
				}
				
				completion(json, ServerResponse(httpResponse))
			}
			
			_ = Alamofire.request(finalPath,
			                      method: method,
			                      parameters: params,
			                      encoding: JSONEncoding.default,
			                      headers: headers).responseJSON(completionHandler: closure)
		}
	}
}
