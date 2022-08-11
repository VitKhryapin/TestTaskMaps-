//
//  UIViewController+Extension.swift
//  TestVigram
//
//  Created by Vitaly Khryapin on 08.08.2022.
//

import Foundation
import UIKit
import MapKit

extension UIViewController {
    func showConfirmAlert(
        title: String,
        message: String?,
        confirmText: String,
        confirmAction: @escaping () -> Void,
        cancelAction: (() -> Void)?
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirmText, style: .default, handler: {_ in confirmAction()})
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in cancelAction?()}
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
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
        polylineRenderer.strokeColor = UIColor.green
        polylineRenderer.lineWidth = 1.0
        return polylineRenderer
    }
}

extension MapViewController: NetworkDataFetcherProtocol {
    func dataFetch(points: [Point], lines: [Line]) {
        getAnnotationLine(lines: lines)
        getAnnotationPoints(points: points)
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
            return indices.contains(index) ? self[index] : nil
    }
}
