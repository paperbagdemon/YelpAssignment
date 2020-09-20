//
//  WebServiceTests.swift
//  YelpAssignmentTests
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import XCTest
import Combine
@testable import Yass

class LiveAPIServiceTests: XCTestCase {
    var bag = Set<AnyCancellable>()

    func testSearchBusiness() {
        let expect = expectation(description: "businessWebservice")
        let service = SearchBusinessAPIService(client: APIClient.defaultClient)
        service.location = "Makati Avenue"
        var serviceError: Error?
        var serviceResult: SearchBusinessAPIServiceResult?

        service.request()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                serviceError = error
            case .finished: ()
            }
            expect.fulfill()
        }) { value in
            serviceResult = value
        }
        .store(in: &bag)
    
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(serviceError, serviceError?.localizedDescription ?? "")
        XCTAssertNotNil(serviceResult, "SearchBusinessAPIService call failed")
    }

    func testFecthBusinessDetail() {
        let expect = expectation(description: "businessDetailsWebservice")
        let service = BusinessDetailAPIService(client: APIClient.defaultClient, businessId: "sFKF4eyP6DKdr2o1qpykig")
        var serviceError: Error?
        var serviceResult: Business?

        service.request()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                serviceError = error
            case .finished: ()
            }
            expect.fulfill()
        }) { value in
            serviceResult = value
        }
        .store(in: &bag)

        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(serviceError, serviceError?.localizedDescription ?? "")
        XCTAssertNotNil(serviceResult, "BusinessDetailAPIService call failed")
    }

    func testFetchReviews() {
        let expect = expectation(description: "reviewsWebservice")
        let service = ReviewAPIService(client: APIClient.defaultClient, businessId: "sFKF4eyP6DKdr2o1qpykig")
        var serviceError: Error?
        var serviceResult: ReviewAPIServiceResult?

        service.request()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                serviceError = error
            case .finished: ()
            }
            expect.fulfill()
        }) { value in
            serviceResult = value
        }
        .store(in: &bag)
        
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(serviceError, serviceError?.localizedDescription ?? "")
        XCTAssertNotNil(serviceResult, "ReviewAPIService is nil")
    }
    
    func testBusinessListViewModel() {
        let expect = expectation(description: "searchBusinesses")
        let viewModel = BusinessesHomeViewModel(apiClient: APIClient.defaultClient)
        viewModel.searchBusinesses(keyword: "food", location: "Makati Avenue", categories: nil)?
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(_): ()
            case .finished: ()
            }
            expect.fulfill()
        }) { _ in
        }
        .store(in: &bag)

        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(viewModel.businesses.error, viewModel.businesses.error?.localizedDescription ?? "")
        XCTAssertNotNil(viewModel.businesses.value, "BusinessListViewModel list is nil")
    }
    
    func testFetchBusinessDetail() {
        let expect = expectation(description: "fetchBusinessDetail")
        let viewModel = BusinessDetailViewModel(apiClient: APIClient.defaultClient, businessID: Stub.testBusinessID, business: nil, reviews: nil)

        viewModel.fetchBusinessDetail()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(_): ()
            case .finished: ()
            }
            expect.fulfill()
        }) { _ in
        }
        .store(in: &bag)

        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(viewModel.business.error, viewModel.business.error?.localizedDescription ?? "")
        XCTAssertNotNil(viewModel.business.value, "BusinessListViewModel list is nil")
    }
    
    func testFetchBusinessReviews() {
        let expect = expectation(description: "fetchBusinessReviews")
        let viewModel = BusinessDetailViewModel(apiClient: APIClient.defaultClient, businessID: Stub.testBusinessID, business: nil, reviews: nil)

        viewModel.fetchBusinessReviews()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(_): ()
            case .finished: ()
            }
            expect.fulfill()
        }) { _ in
        }
        .store(in: &bag)

        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(viewModel.reviews.error, viewModel.reviews.error?.localizedDescription ?? "")
        XCTAssertNotNil(viewModel.reviews.value, "BusinessListViewModel list is nil")
    }
    
    func testFetchNearbyDeals() {
        let coordinates = Coordinates(latitude: 37.7873589, longitude: -122.408227)
        let expect = expectation(description: "fetchNearbyDeals")
        let viewModel = BusinessesHomeViewModel(apiClient: APIClient.defaultClient)

        viewModel.fetchNearbyDeals(coordinates)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(_): ()
            case .finished: ()
            }
            expect.fulfill()
        }) { _ in
        }
        .store(in: &bag)

        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(viewModel.deals.error, viewModel.deals.error?.localizedDescription ?? "")
        XCTAssertNotNil(viewModel.deals.value, "BusinessListViewModel list is nil")
    }

//  TODO: this tests fails to compile when referencing some Mapbox objects
//    func testGeLocations() {
//        let expect = expectation(description: "getLocations")
//        let locationsManager = LocationService.defaultService
//
//        var serviceError: Error?
//        var serviceResult: Any?
//        locationsManager.getLocations(term: "makati avenue").sink(receiveCompletion: { completion in
//            switch completion {
//            case .failure(let error):
//                serviceError = error
//            case .finished: ()
//            }
//            expect.fulfill()
//        }) { value in
//            serviceResult = value
//        }
//        .store(in: &bag)
//
//        waitForExpectations(timeout: 10.0, handler: nil)
//        XCTAssertNil(serviceError, serviceError?.localizedDescription ?? "")
//        XCTAssertNotNil(serviceResult, "getLocations list is nil")
//    }
//
//    func testGetDirections() {
//        let expect = expectation(description: "getLocations")
//        let locationsManager = LocationService.defaultService
//
//        var serviceError: Error?
//        var serviceResult: Any?
//        locationsManager.getDirections(fromCoordinates: Coordinates(latitude: 14.675525, longitude: 121.0437512), toCoordinates: Coordinates(latitude: 14.6032416, longitude: 121.0045141)).sink(receiveCompletion: { completion in
//            switch completion {
//            case .failure(let error):
//                serviceError = error
//            case .finished: ()
//            }
//            expect.fulfill()
//        }) { value in
//            serviceResult = value
//        }
//        .store(in: &bag)
//
//        waitForExpectations(timeout: 30.0, handler: nil)
//        XCTAssertNil(serviceError, serviceError?.localizedDescription ?? "")
//        XCTAssertNotNil(serviceResult, "getDirections list is nil")
//    }

}
