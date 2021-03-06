//
//  YelpAssignmentUITests.swift
//  YelpAssignmentUITests
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import XCTest
@testable import Yass

class YelpAssignmentUITests: XCTestCase {

    func testBusinessListIsLoading() {
        let app = XCUIApplication()
        app.launch()

        let searchField = app.textFields["businessSearchBarView.textFieldSearchTerm"]
        searchField.tap()
        searchField.typeText("restaurants")
        searchField.typeText("\n")

        let countBusinesses = app.tables.children(matching: .cell)
        let exists = NSPredicate(format: "count > 0")

        expectation(for: exists, evaluatedWith: countBusinesses, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testDealsBannerIsLoading() {
        let app = XCUIApplication()
        app.launch()

        let dealsBanner = app.descendants(matching: .any)["dealsBannerView"]
        let exists = NSPredicate(format: "exists > 0")

        expectation(for: exists, evaluatedWith: dealsBanner, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testBusinessDetailsIsLoading() {
        let app = XCUIApplication()
        app.launch()

        let searchField = app.textFields["businessSearchBarView.textFieldSearchTerm"]
        searchField.tap()
        searchField.typeText("restaurants")
        searchField.typeText("\n")

        let countBusinesses = app.tables.children(matching: .cell)
        let exists = NSPredicate(format: "count > 0")
        expectation(for: exists, evaluatedWith: countBusinesses, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)

        app.cells.element(boundBy: 0).tap()
        let businessDetail = app.descendants(matching: .any)["businessDetailView"]
        let exists2 = NSPredicate(format: "exists == 1")
        expectation(for: exists2, evaluatedWith: businessDetail, handler: nil)

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testDirectionsIsLoading() {
        let app = XCUIApplication()
        app.launch()

        let searchField = app.textFields["businessSearchBarView.textFieldSearchTerm"]
        searchField.tap()
        searchField.typeText("restaurants")
        searchField.typeText("\n")

        let countBusinesses = app.tables.children(matching: .cell)
        let exists = NSPredicate(format: "count > 0")
        expectation(for: exists, evaluatedWith: countBusinesses, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)

        app.cells.element(boundBy: 0).tap()
        let businessDetail = app.descendants(matching: .any)["businessDetailView"]
        let exists2 = NSPredicate(format: "exists == 1")
        expectation(for: exists2, evaluatedWith: businessDetail, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)

        let mapsView = app.descendants(matching: .any)["businessDetailView.mapView"]
        mapsView.tap()
        let directionsView = app.descendants(matching: .any)["directionsView"]
        let exists3 = NSPredicate(format: "exists == 1")
        expectation(for: exists3, evaluatedWith: directionsView, handler: nil)
        waitForExpectations(timeout: 4, handler: nil)
    }

    func testSearchBarCategorySuggest() {
        let app = XCUIApplication()
        app.launch()

        app.buttons["businessSearchBarView.buttonLocation"].tap()
        app.buttons["businessSearchBarView.buttonCategories"].tap()
        let textField = app.textFields["businessSearchBarView.textFieldSearchCategories"]
        textField.tap()
        textField.typeText("loc")

        let categorySuggest = app.descendants(matching: .any)["businessSearchBarView.autoSuggestList"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: categorySuggest, handler: nil)
        waitForExpectations(timeout: 7, handler: nil)
    }

    func testSearchBarLocationSuggest() {
        let app = XCUIApplication()
        app.launch()

        app.buttons["businessSearchBarView.buttonLocation"].tap()
        app.buttons["businessSearchBarView.buttonCategories"].tap()
        let textField = app.textFields["businessSearchBarView.textFieldSearchLocation"]
        textField.tap()
        textField.typeText("makati")

        let suggest = app.descendants(matching: .any)["businessSearchBarView.autoSuggestList"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: suggest, handler: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
}
