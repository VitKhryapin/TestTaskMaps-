//
//  TestVigramTests.swift
//  TestVigramTests
//
//  Created by Vitaly Khryapin on 08.08.2022.
//

import XCTest
@testable import TestVigram

class UnitTests: XCTestCase {
    private var viewController: MapViewController!
    private let networkService = NetworkService()
    private var points = [Point]()
    private var lines = [Line]()

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
        viewController.loadViewIfNeeded()
        let point1 = Point(type: .feature, id: "Buz", properties: PointProperties(name: "Biz", propertiesDescription: "Boz", modified: "Biz", color: [0.26666666, 0.36666666], visible: true, latitude: 49.07063189, longitude: 9.76390329, elevation: 378.02488643), geometry: PointGeometry(coordinates: [9.76390329, 49.07063189, 378.02488643]))
        let point2 = Point(type: .feature, id: "Fuz", properties: PointProperties(name: "Fiz", propertiesDescription: "Foz", modified: "Fiz", color: [0.36666666, 0.46666666], visible: true, latitude: 59.07063189, longitude: 19.76390329, elevation: 388.02488643), geometry: PointGeometry(coordinates: [19.76390329, 59.07063189, 388.02488643]))
        points = [point1, point2]
        let line1 = Line(type: .feature, properties: LineProperties(subClasses: "Kaz"), geometry: LineGeometry(type: "Kuz", coordinates: [[9.76373051, 49.06690277, 378.576],[19.76373051, 59.06690277, 388.576]]))
        lines.append(line1)
    }

    override func tearDownWithError() throws {
        viewController = nil
    }
    
    func testLoadAnnotations() throws {
        let expectation = expectation(description: "Expectation in " + #function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3, handler: nil)
        let result = self.viewController.mapView.annotations.count
        XCTAssertNotEqual(result, 0)
    }
    
    func testFetchPointsAndLines() throws {
        viewController.dataFetch(points: points, lines: lines)
        let countPoints = viewController.mapView.annotations.count
        let countLines = viewController.mapView.overlays.count
        XCTAssertEqual(countPoints, points.count)
        XCTAssertEqual(countLines, lines.count)
    }
}
