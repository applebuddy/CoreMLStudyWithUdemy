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
