//
//  URLSessionServiceExecutor.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

import Foundation
import PromiseKit
import PATools

public class URLSessionServiceExecutor: URLServiceExecutor {

    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init(
        session: URLSession,
        decoder: JSONDecoder = .with(
            keyDecodingStrategy: .convertFromSnakeCase
        )
    ) {
        self.session = session
        self.decoder = decoder
    }
    
    public func requestPromise<T>(_ request: URLRequest, type: T.Type) -> Promise<T> where T : Decodable {
        
        return Promise<T> { seal in
            
            request.log()
            
            session.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    seal.reject(WaqayError.networking(.unknown))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    seal.reject(WaqayError.networking(.unknown))
                    return
                }
                httpResponse.log(
                    with: data
                )
                guard 200..<300 ~= httpResponse.statusCode else {
                    let returnError: WaqayError
                    switch httpResponse.statusCode {
                    case 500: returnError = .networking(.server(.internalError(error)))
                    case 400: returnError = .networking(.client(.badRequest))
                    case 401: returnError = .networking(.client(.unauthorized))
                    case 403: returnError = .networking(.client(.forbidden))
                    case 404: returnError = .networking(.client(.notFound))
                    default: returnError = .networking(.unknown)
                    }
                    seal.reject(returnError)
                    return
                }
                if let data = data {
                  do {
                    let payload = try self.decoder.decode(T.self, from: data)
                    seal.fulfill(payload)
                  } catch {
                    seal.reject(error)
                  }
                } else {
                  seal.reject(WaqayError.networking(.unknown))
                }
            }.resume()
        }
    }
}

extension JSONDecoder {
    public static func with(
        keyDecodingStrategy: KeyDecodingStrategy
    ) -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        return decoder
    }
}

