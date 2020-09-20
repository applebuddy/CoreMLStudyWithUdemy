//
//  UIImage+Extension.swift
//  Image Analyzer
//
//  Created by MinKyeongTae on 2020/06/03.
//  Copyright © 2020 Nyisztor, Karoly. All rights reserved.
//

import UIKit

extension UIImage {
    var cgOrientation: CGImagePropertyOrientation {
        switch imageOrientation {
        case .up: return .up
        case .upMirrored: return .upMirrored
        case .down: return .down
        case .downMirrored: return .downMirrored
        case .leftMirrored: return .leftMirrored
        case .right: return .right
        case .rightMirrored: return .rightMirrored
        case .left: return .left
        }
    }
}
