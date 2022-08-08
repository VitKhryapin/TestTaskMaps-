//
//  NetworkDataFetcher.swift
//  TestVigram
//
//  Created by Vitaly Khryapin on 07.08.2022.
//

import Foundation
import MapKit

class NetworkDataFetcher {
    let networkService = NetworkService()
    var points = [Point]()
    var lines = [Line]()
    var mapVC: MapViewController!
    
    func dataFetch() {
        networkService.getObjects { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let result):
                    guard let points = result?.points else { return }
                    guard let lines = result?.lines else { return }
                    self.points = points
                    self.lines = lines
                    self.getAnnotationPoints()
                    self.getAnnotationLine()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getAnnotationPoints(){
        for point in points {
            let annotationPoint = MKPointAnnotation()
            annotationPoint.title = point.properties.name
            annotationPoint.coordinate = CLLocationCoordinate2D(latitude: point.geometry.coordinates[0], longitude: point.geometry.coordinates[1])
            mapVC.mapView.addAnnotation(annotationPoint)
        }
    }
    
    func getAnnotationLine(){
        for line in lines {
            let coordinatPoint1 = line.geometry.coordinates[0]
            let coordinatPoint2 = line.geometry.coordinates[1]
            let point1 = CLLocationCoordinate2D(latitude: coordinatPoint1[0], longitude: coordinatPoint1[1])
            let point2 = CLLocationCoordinate2D(latitude: coordinatPoint2[0], longitude: coordinatPoint2[1])
            mapVC.mapView.addOverlay(MKPolyline(coordinates: [point1, point2], count: 2))
        }
    }
}


