//
//  WaqayRadiosRemoteDataAPI.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import Foundation
import PromiseKit

public class WaqayRadiosRemoteDataAPI {
    
    let urlSession = URLSession()
    let domain = "https://private-e1862-waqay.apiary-mock.com/api/v1"
    
    public init() { }
}

extension WaqayRadiosRemoteDataAPI: RadiosDataRemoteAPI {
    public func getRadiosData() -> Promise<[RadioData]> {
        return Promise<[RadioData]> { seal in
            let urlString = "\(domain)/radio-stations"
            
            guard let url = URL(string: urlString) else {
                seal.reject(RemoteAPIError.createURL)
                return
            }
            
            urlSession.dataTask(with: url) { (data, response, error) in
                if let error = error {
                  seal.reject(error)
                  return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                  seal.reject(RemoteAPIError.unknown)
                  return
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                  seal.reject(RemoteAPIError.httpError)
                  return
                }
                guard let data = data else {
                  seal.reject(RemoteAPIError.unknown)
                  return
                }
                do {
                  let decoder = JSONDecoder()
                  let radios = try decoder.decode([RadioData].self, from: data)
                  seal.fulfill(radios)
                } catch let error as NSError {
                  seal.reject(error)
                }
            }.resume()
        }
    }
}
