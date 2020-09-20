//
//  ViewController.swift
//  Image Analyzer
//
//  Created by Nyisztor, Karoly on 10/14/18.
//  Copyright © 2018 Nyisztor, Karoly. All rights reserved.
//

// MARK: - Analyzing Still Images using Vision
// - Vision으로부터 무언가를 감지하게 하고 싶다면,
// 1. VisionRequest를 호출합니다.
// 2. VisionRequest 결과를 처리하기 위한 Request Handler를 처리합니다.
// 3. Request Type에 따라서 VisionRequest의 감지 결과값을 Observation 배열로 받을 수 있습니다.
// -> 감지할 수 있는 Observation Type은 바코드, 텍스트, 이미지, 모양 등 다양한 Type이 있습니다. 
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func takePicture() {
        // Show options for the source picker only if the camera is available.
        // - 만약 카메라 촬영이 사용 불가하다면, 사진앨범 타입의 이미지 피커를 띄운다.
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }
        
        // 카메라, 사진앨범을 모두 지원하면, 옵션으로 선택할 수 있도록 AlertAction을 추가한다.
        let photoSourcePicker = UIAlertController()
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .camera)
        }
        let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .photoLibrary)
        }
        
        photoSourcePicker.addAction(takePhoto)
        photoSourcePicker.addAction(choosePhoto)
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(photoSourcePicker, animated: true)
    }
    
    private func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Handling Image Picker Selection
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        
        // We always expect `imagePickerController(:didFinishPickingMediaWithInfo:)` to supply the original image.
        guard let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
        //guard let uiImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            fatalError("Error! Could not retrieve image from image picker.")
        }
        
        imageView.image = uiImage
    }
}
