//
//  SearchBusinessService.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation
import Alamofire
import Combine

struct APIServiceError: LocalizedError {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var errorDescription: String? {
        get {
            return self.message
        }
    }
}

class APIService<T: Decodable> {
    private let client: APIClientProtocol

    init(client: APIClient) {
        self.client = client
    }
// MARK: Properties
    var httpMethod: Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod.get
    }
    var parameters: Alamofire.Parameters {
        return [:]
    }
    var paramEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    var endpoint: String {
        return ""
    }
    var url: URLConvertible {
        return self.client.baseUrl.appendingPathComponent(endpoint)
    }
// MARK: Base methods
    func request() -> Future<T?, Error> {
        let future = Future<T?, Error> { promise in
            self.client.session.request(self.url,
                             method: self.httpMethod,
                             parameters: self.parameters,
                             encoding: self.paramEncoding).validate().responseDecodable(of: T.self) { (data) in
                                if data.error != nil {
                                    promise(.failure(APIServiceError(data.error?.localizedDescription ?? "Network Error")))
                                } else {
                                    do {
                                        try promise(.success(data.result.get()))
                                    } catch {
                                        promise(.failure(error))
                                    }
                                }
            }
        }
        return future
    }
}
