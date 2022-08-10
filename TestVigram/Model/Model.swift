//
//  Model.swift
//  TestVigram
//
//  Created by Vitaly Khryapin on 06.08.2022.
//

import Foundation

// MARK: - Empty
struct ResultObjects: Codable {
    var points: [Point]
    let lines: [Line]

    enum CodingKeys: String, CodingKey {
        case points = "Points"
        case lines = "Lines"
    }
}

// MARK: - Line
struct Line: Codable {
    let type: LineType?
    let properties: LineProperties
    let geometry: LineGeometry
}

// MARK: - LineGeometry
struct LineGeometry: Codable {
    let type: String
    let coordinates: [[Double]]
}

// MARK: - LineProperties
struct LineProperties: Codable {
    let subClasses: String

    enum CodingKeys: String, CodingKey {
        case subClasses = "SubClasses"
    }
}

enum LineType: String, Codable {
    case feature = "Feature"
}

// MARK: - Point
struct Point: Codable {
    let type: LineType
    let id: String
    let properties: PointProperties
    let geometry: PointGeometry
}

// MARK: - PointGeometry
struct PointGeometry: Codable {
    let coordinates: [Double]
}

// MARK: - PointProperties
struct PointProperties: Codable {
    let name, propertiesDescription: String
    let modified: String
    let color: [Double]
    let visible: Bool
    let latitude, longitude, elevation: Double

    enum CodingKeys: String, CodingKey {
        case name
        case propertiesDescription = "description"
        case modified, color, visible, latitude, longitude, elevation
    }
}
