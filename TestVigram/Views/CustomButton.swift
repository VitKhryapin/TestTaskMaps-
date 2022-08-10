//
//  CustomButton.swift
//  TestVigram
//
//  Created by Vitaly Khryapin on 08.08.2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    private lazy var buttonLayer: CALayer  = {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        return layer
    }()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if buttonLayer.superlayer != nil {
           buttonLayer.insertSublayer(layer, at: 0)
        }
    }
}
