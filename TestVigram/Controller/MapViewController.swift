//
//  MapViewController.swift
//  TestVigram
//
//  Created by Vitaly Khryapin on 06.08.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var buttonLoad: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    let networkDataFetch = NetworkDataFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        networkDataFetch.mapVC = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    // MARK: - LoadData and SetupManager
    func loadData() {
        networkDataFetch.dataFetch()
    }
    
    func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK: - CheckAuthorization
    func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled(){
            setupManager()
            checkAuthorization()
        }else{
            showAlertLocation(title: "У Вас выключена служба геолакации", message: "Хотите включить?", url: URL(string: UIApplication.openSettingsURLString))
        }
    }
    
    func checkAuthorization(){
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
            showAlertLocation(title: "Вы запретили использование местоположения", message: "Хотите это изменить?", url: URL(string: UIApplication.openSettingsURLString))
            break
        @unknown default:
            break
        }
    }
    
    // MARK: - IBAction
    @IBAction func buttonAction(_ sender: UIButton) {
        loadData()
    }
}

// MARK: - Delegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate{
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 10_000_000, longitudinalMeters: 10_000_000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        polylineRenderer.strokeColor = .green
        polylineRenderer.lineWidth = 5.0
        return polylineRenderer
    }
}
