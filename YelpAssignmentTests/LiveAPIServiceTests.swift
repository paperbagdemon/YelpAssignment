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
        let service = SearchBusinessAPIService(client: APIClient.defaultClient)
        service.location = "Makati Avenue"
        var serviceError: Error?
        var serviceResult: SearchBusinessAPIServiceResult?
        service.request { result, error -> Void in
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
        let service = BusinessDetailAPIService(client: APIClient.defaultClient, businessId: "sFKF4eyP6DKdr2o1qpykig")
        var serviceError: Error?
        var serviceResult: Business?
        service.request { (result, error) in
            serviceResult = result
            serviceError = error
            expect.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(serviceError, serviceError?.localizedDescription ?? "")
        XCTAssertNotNil(serviceResult, "BusinessDetailAPIService call failed")
    }
    
    func testFetchReviews() {
        let expect = expectation(description: "reviewsWebservice")
        let service = ReviewAPIService(client: APIClient.defaultClient, businessId: "sFKF4eyP6DKdr2o1qpykig")
        var serviceError: Error?
        var serviceResult: ReviewAPIServiceResult?
        service.request { (result, error) in
            serviceResult = result
            serviceError = error
            expect.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(serviceError, serviceError?.localizedDescription ?? "")
        XCTAssertNotNil(serviceResult, "ReviewAPIService is nil")
    }
    
    func testBusinessListViewModel() {
        let expect = expectation(description: "searchBusinesses")
        let viewModel = BusinessesHomeViewModel(apiClient: APIClient.defaultClient)
        viewModel.searchBusinesses(keyword: "food", location: "Makati Avenue") { businesses, error in
            expect.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(viewModel.businesses.error, viewModel.businesses.error?.localizedDescription ?? "")
        XCTAssertNotNil(viewModel.businesses.value, "BusinessListViewModel list is nil")
    }
    
    func testFetchBusinessDetail() {
        let expect = expectation(description: "fetchBusinessDetail")
        let viewModel = BusinessDetailViewModel(apiClient: APIClient.defaultClient, businessID: Stub.testBusinessID, business: nil, reviews: nil)
        viewModel.fetchBusinessDetail { (business, error) in
            expect.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(viewModel.business.error, viewModel.business.error?.localizedDescription ?? "")
        XCTAssertNotNil(viewModel.business.value, "BusinessListViewModel list is nil")
    }
    
    func testFetchBusinessReviews() {
        let expect = expectation(description: "fetchBusinessReviews")
        let viewModel = BusinessDetailViewModel(apiClient: APIClient.defaultClient, businessID: Stub.testBusinessID, business: nil, reviews: nil)
        viewModel.fetchBusinessReviews { (business, error) in
            expect.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(viewModel.reviews.error, viewModel.reviews.error?.localizedDescription ?? "")
        XCTAssertNotNil(viewModel.reviews.value, "BusinessListViewModel list is nil")
    }
}
