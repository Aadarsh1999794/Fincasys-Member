//
//  RadialGradientSqureView.swift
//  Finca
//
//  Created by anjali on 14/08/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class RadialGradientSqureView: UIView {
    
    @IBInspectable var InsideColor: UIColor = UIColor.clear
    @IBInspectable var OutsideColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        //layer.cornerRadius = frame.width / 2
        backgroundColor = .clear
        let colors = [InsideColor.cgColor, OutsideColor.cgColor] as CFArray
        let endRadius = min(frame.width, frame.height) 
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        UIGraphicsGetCurrentContext()!.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    }
}
