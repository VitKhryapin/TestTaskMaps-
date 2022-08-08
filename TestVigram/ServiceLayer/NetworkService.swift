//
//  NetworkService.swift
//  TestVigram
//
//  Created by Vitaly Khryapin on 06.08.2022.
//

import Foundation

class NetworkService {
    func getObjects(completion: @escaping (Result<ResultObjects?, Error>) -> ()) {
        let urlString = "http://a0532495.xsph.ru/getPoint"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try JSONDecoder().decode(ResultObjects.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
