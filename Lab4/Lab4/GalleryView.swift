//
//  GalleryView.swift
//  Lab4
//
//  Created by vsevolod on 20.10.2024.
//  Copyright © 2024 vsevolod. All rights reserved.
//

import UIKit

class GalleryView: UIView {
    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
}
