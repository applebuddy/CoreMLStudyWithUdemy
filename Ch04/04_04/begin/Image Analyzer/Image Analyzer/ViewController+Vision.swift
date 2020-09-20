//
//  ViewController+Vision.swift
//  Image Analyzer
//
//  Created by MinKyeongTae on 2020/06/03.
//  Copyright © 2020 Nyisztor, Karoly. All rights reserved.
//

// MARK: - ViewController+Vision
import UIKit
import Vision

extension ViewController {
    var detectionRequest: VNDetectRectanglesRequest {
        // MARK: VNDetectRectanglesRequest 사용 예시
        let request = VNDetectRectanglesRequest { (request, error) in
            // error가 존재한다면, 해당 에러를 출력한다.
            if let detectError = error as NSError? {
                print(detectError)
                return
            } else {
                // 감지된 Observation이 존재하는지 확인, 존재하면 해당 Observation을 출력한다.
                guard let observations = request.results as? [VNDetectedObjectObservation] else {
                    return
                }
                print(observations)
            }
        }
        return request
    }
    
    func performVisionRequest(image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage,
                                                        orientation: image.cgOrientation,
                                                        options: [:])
        let requests = [detectionRequest]
        
        // - 이미지 감지결과 연산 간에(do-try catch) 비동기 작업으로 처리한다.
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try imageRequestHandler.perform(requests)
            } catch let error {
                print(error)
                return
            }
        }
    }
    
    private func visualizeObservations(_ observations: [VNDetectedObjectObservation]) {
        DispatchQueue.main.async {
            // - 감지된 observations가 올바른 데이터인지 확인한다.
            guard let image = self.imageView.image else {
                print("Filaed to retrieve image")
                return
            }
            
            let imageSize = image.size
            
            // - Quartz 2D ~ UIKit 간 좌표계 시스템이 다르기 때문에 이미지를 뒤집어서 위치 조정이 필요하다.
            // 1. 위로 뒤집고, 기존 위치로 위치를 내린다.
            var transform = CGAffineTransform.identity.scaledBy(x: 1, y: -1).translatedBy(x: 0, y: -imageSize.height)
            // 2. 이후 UIKit 좌표계에 맞게 이미지 사이즈를 조절해준다.
            transform = transform.scaledBy(x: imageSize.width, y: imageSize.height)
            
        }
    }
}


//import Vision
//
//extension ViewController {
//    var detectionRequest: VNDetectRectanglesRequest {
//        let request = VNDetectRectanglesRequest { (request, error) in
//            if let detectError = error as NSError? {
//                print(detectError)
//                return
//            } else {
//                guard let observations = request.results as? [VNDetectedObjectObservation] else {
//                    return
//                }
//
//                print("\(observations)")
//            }
//        }
//        return request
//    }
//
//    func performVisionRequest(image: UIImage) {
//        guard let cgImage = image.cgImage else {
//            return
//        }
//
//        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: image.cgOrientation, options: [:])
//        let requests = [detectionRequest]
//        do {
//            try imageRequestHandler.perform(requests)
//        } catch let error as NSError {
//            print("\(error) occurred")
//        }
//        DispatchQueue.global(qos: .userInitiated).async {
//            do {
//                try imageRequestHandler.perform(requests)
//            } catch let error as NSError {
//                print("Failed to perform image request: \(error)")
//                return
//            }
//        }
//    }
//}
