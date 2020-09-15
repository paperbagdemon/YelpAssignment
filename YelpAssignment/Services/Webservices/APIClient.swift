//
//  NetworkManager.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    public static let defaultClient = APIClient(apiKey: Setting.yelpAPIKey, baseURL: URL(string: Setting.yelpBaseURL)!)
    public var apiKey: String
    public var baseUrl: URL
    public lazy var session: Alamofire.Session = {
        var headers = HTTPHeaders.default
        headers["Authorization"] = "Bearer \(apiKey)"
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers.dictionary
        return Alamofire.Session(configuration: configuration)
    }()
    init(apiKey: String, baseURL: URL) {
        self.apiKey = apiKey
        self.baseUrl = baseURL
    }
}
