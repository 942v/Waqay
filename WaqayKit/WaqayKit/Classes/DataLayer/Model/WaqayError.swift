//
//  WaqayError.swift
//  WaqayKit
//
//  Created by Guillermo Sáenz on 3/13/21.
//

public enum WaqayError: Error {
    case unknown
    case cache(Cache)
    case networking(Networking)
    
    public enum Cache {
        case empty
        case notFound(String)
    }

    public enum Networking {
        case client(Client)
        case server(Server)
        case unknown

        public enum Client {
            case notFound
            case badRequest
            case forbidden
            case unauthorized
            case decoding(Error)
        }

        public enum Server {
            case internalError(Error?)
            case timeout
        }
    }
}
