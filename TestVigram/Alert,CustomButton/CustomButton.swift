//
//  CustomButton.swift
//  TestVigram
//
//  Created by Vitaly Khryapin on 08.08.2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    lazy var buttonLayer: CALayer  = {
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        return layer
    }()
    override var bounds: CGRect {
        didSet {
            updateButton()
        }
    }
    
    func updateButton() {
        if buttonLayer.superlayer == nil {
            self.buttonLayer.insertSublayer(layer, at: 0)
        }
        buttonLayer.frame = self.bounds
    }
}
