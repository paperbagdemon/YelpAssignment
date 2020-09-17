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
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(serviceError, serviceError?.localizedDescription ?? "")
        XCTAssertNotNil(serviceResult, "SearchBusinessAPIService call failed")
    }
    
    func testFecthBusinessDetail() {
        let expect = expectation(description: "businessDetailsWebservice")
        let businessInfoService = BusinessDetailAPIService(client: APIClient.defaultClient, businessId: "sFKF4eyP6DKdr2o1qpykig")
        var serviceError: Error?
        var serviceResult: Business?
        businessInfoService.request { (result, error) in
            serviceResult = result
            serviceError = error
            expect.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(serviceError, serviceError?.localizedDescription ?? "")
        XCTAssertNotNil(serviceResult, "BusinessDetailAPIService call failed")
    }
    
    func testFetchReviews(){
        let expect = expectation(description: "reviewsWebservice")
        let businessInfoService = ReviewAPIService(client: APIClient.defaultClient, businessId: "sFKF4eyP6DKdr2o1qpykig")
        var serviceError: Error?
        var serviceResult: ReviewAPIServiceResult?
        businessInfoService.request { (result, error) in
            serviceResult = result
            serviceError = error
            expect.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(serviceError, serviceError?.localizedDescription ?? "")
        XCTAssertNotNil(serviceResult, "ReviewAPIService is nil")
    }
}
