//
//  ViewController+Vision.swift
//  Image Analyzer
//
//  Created by MinKyeongTae on 2020/06/03.
//  Copyright © 2020 Nyisztor, Karoly. All rights reserved.
//

import UIKit
import Vision

extension ViewController {
    var detectionRequest: VNDetectRectanglesRequest {
        let request = VNDetectRectanglesRequest { (request, error) in
            if let detectError = error as NSError? {
                print(detectError)
                return
            } else {
                guard let observations = request.results as? [VNDetectedObjectObservation] else {
                    return
                }
                
                print("\(observations)")
            }
        }
        return request
    }
    
    func performVisionRequest(image: UIImage) {
        guard let cgImage = image.cgImage else {
            return
        }
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: image.cgOrientation, options: [:])
        let requests = [detectionRequest]
        do {
            try imageRequestHandler.perform(requests)
        } catch let error as NSError {
            print("\(error) occurred")
        }
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try imageRequestHandler.perform(requests)
            } catch let error as NSError {
                print("Failed to perform image request: \(error)")
                return
            }
        }
    }
}
