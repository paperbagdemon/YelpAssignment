import XCTest
@testable import MapboxDirections

class IntersectionTests: XCTestCase {
    func testCoding() {
        let intersectionsJSON: [[String: Any?]] = [
            [
                "out": 0,
                "in": -1,
                "entry": [true],
                "bearings": [80],
                "location": [13.426579, 52.508068],
                "classes": ["toll", "restricted"],
            ],
            [
                "out": 1,
                "in": 2,
                "entry": [false, true, true],
                "bearings": [30, 120, 300],
                "location": [13.426688, 52.508022],
            ],
            [
                "lanes": [
                    [
                        "valid": true,
                        "indications": ["straight"],
                    ],
                    [
                        "valid": true,
                        "indications": ["right", "straight"],
                    ],
                ],
                "out": 0,
                "in": 2,
                "entry": [true, true, false],
                "bearings": [45, 135, 255],
                "location": [-84.503956, 39.102483],
            ],
        ]
        let intersectionsData = try! JSONSerialization.data(withJSONObject: intersectionsJSON, options: [])
        var intersections: [Intersection]?
        XCTAssertNoThrow(intersections = try JSONDecoder().decode([Intersection].self, from: intersectionsData))
        XCTAssertEqual(intersections?.count, 3)
        
        if let intersection = intersections?.first {
            XCTAssertEqual(intersection.outletRoadClasses, [.toll, .restricted])
            XCTAssertEqual(intersection.headings, [80.0])
            XCTAssertEqual(intersection.location, CLLocationCoordinate2D(latitude: 52.508068, longitude: 13.426579))
        }
        
        intersections = [
            Intersection(location: CLLocationCoordinate2D(latitude: 52.508068, longitude: 13.426579),
                         headings: [80.0],
                         approachIndex: -1,
                         outletIndex: 0,
                         outletIndexes: IndexSet([0]),
                         approachLanes: nil,
                         usableApproachLanes: nil,
                         outletRoadClasses: [.toll, .restricted]),
            Intersection(location: CLLocationCoordinate2D(latitude: 52.508022, longitude: 13.426688),
                         headings: [30.0, 120.0, 300.0],
                         approachIndex: 2,
                         outletIndex: 1,
                         outletIndexes: IndexSet([1, 2]),
                         approachLanes: nil,
                         usableApproachLanes: nil,
                         outletRoadClasses: nil),
            Intersection(location: CLLocationCoordinate2D(latitude: 39.102483, longitude: -84.503956),
                         headings: [45, 135, 255],
                         approachIndex: 2,
                         outletIndex: 0,
                         outletIndexes: IndexSet([0, 1]),
                         approachLanes: [.straightAhead, [.straightAhead, .right]],
                         usableApproachLanes: IndexSet([0, 1]),
                         outletRoadClasses: nil)
        ]
        
        let encoder = JSONEncoder()
        var encodedData: Data?
        XCTAssertNoThrow(encodedData = try encoder.encode(intersections))
        XCTAssertNotNil(encodedData)
        
        if let encodedData = encodedData {
            var encodedIntersectionsJSON: [[String: Any?]]?
            XCTAssertNoThrow(encodedIntersectionsJSON = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [[String: Any?]])
            XCTAssertNotNil(encodedIntersectionsJSON)

            XCTAssert(JSONSerialization.objectsAreEqual(intersectionsJSON, encodedIntersectionsJSON, approximate: true))
        }
    }
}
