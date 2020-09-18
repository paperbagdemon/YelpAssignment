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

class APIService<T: Decodable> {
    private let client: APIClient
    init(client: APIClient) {
        self.client = client
    }
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
    func request( completion: @escaping (T?, Error?) -> Void) {
        self.client.session.request(self.url,
                         method: self.httpMethod,
                         parameters: self.parameters,
                         encoding: self.paramEncoding).validate().responseDecodable(of: T.self) { (data) in
                            do {
                                try completion(data.result.get(), data.error)
                            } catch {
                                completion(nil, data.error)
                            }
        }
    }
}
