//
//  YelpAssignmentTests.swift
//  YelpAssignmentTests
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import XCTest
@testable import Yass

class YelpAssignmentTests: XCTestCase {
    
    //TODO: why is this failing
    func testSuggesCategories(){
        let categories = Setting.defaultSettings.suggestCategory(term: "loc")
        XCTAssert(categories.count > 0)
    }

}
