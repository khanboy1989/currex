//
//  Endpoint.swift
//  Currex
//
//  Created by Serhan Khan on 17/01/2021.
//

import Foundation

public class Endpoint<R>:ResponseRequestable{
    public var responseDecoder: ResponseDecoder
    
    public typealias Response = R
    
    public var path: String
    
    public var isFullPath: Bool
    
    public var method: HTTPMethodType
    
    public var headerParameters: [String : String]
    
    public var queryParametersEncodable: Encodable?
    
    public var queryParameters: [String : Any]
    
    public var bodyParametersEncodable: Encodable?
    
    public var bodyParameters: [String : Any]
    
    public var bodyEncoding: BodyEncodingType
    
    init(path:String,
         isFullPath:Bool = false,
         method:HTTPMethodType,
         headersParameters:[String:String] = [:],
         queryParametersEncodable:Encodable? = nil,
         queryParameters:[String:Any] = [:],
         bodyParametersEncodable:Encodable? = nil,
         bodyParameters:[String:Any] = [:],
         bodyEncoding:BodyEncodingType = .jsonSerializationData,
         responseDecoder:ResponseDecoder = JSONResponseDecoder()){
       
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParameters = headersParameters
        self.queryParametersEncodable = queryParametersEncodable
        self.queryParameters = queryParameters
        self.bodyParametersEncodable = bodyParametersEncodable
        self.bodyParameters = bodyParameters
        self.bodyEncoding = bodyEncoding
        self.responseDecoder = responseDecoder
    }
    
    
    
}

public protocol Requestable{
    var path:String {get}
    var isFullPath:Bool {get}
    var method: HTTPMethodType {get}
    var headerParameters:[String:String]{get}
    var queryParametersEncodable:Encodable?{get}
    var queryParameters:[String:Any]{get}
    var bodyParametersEncodable:Encodable? {get}
    var bodyParameters:[String:Any]{get}
    var bodyEncoding:BodyEncodingType{get}
    
    func urlRequest(with networkConfig:NetworkConfigurable) throws -> URLRequest
}

public protocol ResponseRequestable:Requestable{
   associatedtype Response
    var responseDecoder:ResponseDecoder{get}
}

enum RequestGenrationError:Error{
    case components
}


extension Requestable{
    
    func url(with config:NetworkConfigurable) throws -> URL {
        
        let baseUrl = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
        
        let endpoint = isFullPath ? path : baseUrl.appending(path)
        guard var urlComponents = URLComponents(string: endpoint) else {throw RequestGenrationError.components }
        
        var urlQueryItems = [URLQueryItem]()
        
        let queryParameters = try queryParametersEncodable?.toDictionary() ?? self.queryParameters
        
        queryParameters.forEach{
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))}
        
        config.queryParameters.forEach{
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        
        guard let url = urlComponents.url else {throw RequestGenrationError.components}
        
        return url
     
    }
    
    public func urlRequest(with config:NetworkConfigurable) throws -> URLRequest{
        
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders:[String:String] = config.headers
        
        headerParameters.forEach{allHeaders.updateValue($1, forKey: $0)}
        
        let bodyParameters = try bodyParametersEncodable?.toDictionary() ?? self.bodyParameters
        
        if !bodyParameters.isEmpty {
            urlRequest.httpBody = encodeBody(bodyParamaters: bodyParameters, bodyEncoding: bodyEncoding)
        }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        
        return urlRequest
    }
    
    private func encodeBody(bodyParamaters: [String: Any], bodyEncoding: BodyEncodingType) -> Data? {
        switch bodyEncoding {
        case .jsonSerializationData:
            return try? JSONSerialization.data(withJSONObject: bodyParamaters)
        case .stringEndodingAscii:
            return bodyParamaters.queryString.data(using: String.Encoding.ascii, allowLossyConversion: true)
        }
    }
}
