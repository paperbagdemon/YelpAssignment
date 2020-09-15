//
//  WebServiceTests.swift
//  YelpAssignmentTests
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import XCTest
@testable import YelpAssignment

class LiveAPIServiceTests: XCTestCase {
    func testSearchBusiness() {
        let expect = expectation(description: "businessWebservice")
        let searchBusiness = SearchBusinessAPIService(client: APIClient.defaultClient)
        searchBusiness.location = "Makati Avenue"
        var serviceError: Error?
        var serviceResult: SearchBusinessAPIServiceResult?
        searchBusiness.request { result, error -> Void in
            serviceResult = result
            serviceError = error
            expect.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertNil(serviceError, "SearchBusinessAPIService call failed")
        XCTAssertNotNil(serviceResult, "SearchBusinessAPIService call failed")
    }
}
