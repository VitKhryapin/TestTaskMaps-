//
//  Protocols.swift
//  TestVigram
//
//  Created by Vitaly Khryapin on 09.08.2022.
//

import Foundation

protocol NetworkDataFetcherProtocol: AnyObject {
    func dataFetch(points: [Point], lines: [Line])
}
