//
//  YelpAssignmentTests.swift
//  YelpAssignmentTests
//
//  Created by Ryan Dale Apo on 9/15/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import XCTest
@testable import YelpAssignment

class YelpAssignmentTests: XCTestCase {
    
    //TODO: why is this failing
    func testSuggesCategories(){
        let _ = Category.presets
        let categories = Category.suggestCategory(term: "accesso")
        XCTAssert(categories.count > 0)
    }

}
