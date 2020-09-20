//
//  UIImage+Extension.swift
//  Image Analyzer
//
//  Created by MinKyeongTae on 2020/06/03.
//  Copyright © 2020 Nyisztor, Karoly. All rights reserved.
//

import UIKit

extension UIImage {
    /// - 감지할 이미지의 위치를 보정하기 위해 사용한다.
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
