//
//  TestVigramTests.swift
//  TestVigramTests
//
//  Created by Vitaly Khryapin on 08.08.2022.
//

import XCTest
@testable import TestVigram

class UnitTests: XCTestCase {
    var vc: MapViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
        vc.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        vc = nil
    }
    
    func testLoadAnnotations() throws {
        let expectation = expectation(description: "Expectation in " + #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3, handler: nil)
        let result = self.vc.mapView.annotations.count
        XCTAssertNotEqual(result, 0)
    }
    
    func testLoadPointsAndLines() throws {
        let expectation = expectation(description: "Expectation in " + #function)
        vc.loadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3, handler: nil)
        let countPoints = self.vc.networkDataFetch.points.count
        let countLines = self.vc.networkDataFetch.lines.count
        XCTAssertNotEqual(countPoints, 0)
        XCTAssertNotEqual(countLines, 0)
    }
    
}
