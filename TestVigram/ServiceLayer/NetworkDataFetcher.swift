//
//  NetworkDataFetcher.swift
//  TestVigram
//
//  Created by Vitaly Khryapin on 07.08.2022.
//

import Foundation
import MapKit

final class NetworkDataFetcher {
    private let networkService = NetworkService()
    weak var delegate: NetworkDataFetcherProtocol?
    func dataFetch() {
        networkService.getObjects { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let result):
                    guard let points = result?.points else { return }
                    guard let lines = result?.lines else { return }
                    self.delegate?.dataFetch(points: points, lines: lines)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
