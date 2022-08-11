//
//  MapViewController.swift
//  TestVigram
//
//  Created by Vitaly Khryapin on 06.08.2022.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    private let networkDataFetch = NetworkDataFetcher()
    private var delegate: NetworkDataFetcherProtocol?
    private var points = [Point]()
    private var lines = [Line]()
    
    // MARK: - Outlet
    @IBOutlet weak var buttonLoad: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        networkDataFetch.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    override func viewDidLayoutSubviews() {
        buttonLoad.layer.cornerRadius = 15
    }
    
    // MARK: - LoadData
    private func loadData() {
        networkDataFetch.dataFetch()
    }
    
    // MARK: - SettingsLocationManager
    private func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK: - AuthorizationBlock
    private func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setupManager()
            checkAuthorization()
        } else {
            showConfirmAlert(title: "У Вас выключена служба геолакации", message: "Хотите включить?", confirmText: "Ok") {
                let url = URL(string: UIApplication.openSettingsURLString)
                if let url = url {
                    UIApplication.shared.open(url)
                }
            } cancelAction: {
                self.checkLocationEnabled()
            }
        }
    }
    
    func checkAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            showConfirmAlert(title: "Вы запретили использование местоположения", message: "Хотите это изменить?", confirmText: "Ok") {
                let url = URL(string: UIApplication.openSettingsURLString)
                if let url = url {
                    UIApplication.shared.open(url)
                }
            } cancelAction: {
                self.checkAuthorization()
            }
            break
        @unknown default:
            break
        }
    }
    
    // MARK: - AnnotationsBlock
    func getAnnotationLine(lines: [Line]) {
        let geomtryLines = lines.map({$0.geometry.coordinates})
        for coordinatesLine in geomtryLines {
            var pointsCoordination = [CLLocationCoordinate2D]()
            for coordinate in coordinatesLine {
                guard let latitude = coordinate[safe: 1] else {return}
                guard let longitude = coordinate[safe: 0] else {return}
                let point = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                pointsCoordination.append(point)
            }
            mapView.addOverlay(MKPolyline(coordinates: pointsCoordination, count: pointsCoordination.count))
        }
    }
    
    func getAnnotationPoints(points: [Point]) {
        for point in points {
            let annotationPoint = MKPointAnnotation()
            annotationPoint.title = point.properties.name
            guard let latitude =  point.geometry.coordinates[safe: 1] else {return}
            guard let longitude = point.geometry.coordinates[safe: 0] else {return}
            annotationPoint.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapView.addAnnotation(annotationPoint)
        }
    }
    
    // MARK: - IBActionButton
    @IBAction func buttonAction(_ sender: UIButton) {
        loadData()
    }
}
