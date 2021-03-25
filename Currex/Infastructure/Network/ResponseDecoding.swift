//
//  ResponseDecoding.swift
//  Currex
//
//  Created by Serhan Khan on 17/01/2021.
//

import Foundation

//MARK: - Response Decoder Protocol
public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

//MARK: - JSONResponseDecoder
public class JSONResponseDecoder:ResponseDecoder{
    private let jsonDecoder = JSONDecoder()
    public init(){}
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}


public class RawDataResponseDecoder: ResponseDecoder {
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
