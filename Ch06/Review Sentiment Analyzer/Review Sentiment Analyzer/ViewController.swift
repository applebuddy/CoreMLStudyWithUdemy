//
//  ViewController.swift
//  Review Sentiment Analyzer
//
//  Created by MinKyeongTae on 2020/10/05.
//  Copyright © 2020 MungGu. All rights reserved.
//

// ReviewClassifier.mlmodel 사용을 위해 NaturalLangage framework를 import 한다.
import UIKit
import NaturalLanguage

class ViewController: UIViewController {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sentimentImageView: UIImageView!
    
    // - Loading NaturalLangauge Model
    private lazy var sentimentClassifier: NLModel? = {
        let model = try? NLModel(mlModel: ReviewClassifier().model)
        return model
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearButton.addTarget(self, action: #selector(clearButtonPressed(_:)), for: .touchUpInside)
    }
    
    // MARK: - Event
    
    @objc func clearButtonPressed(_ sender: UIButton) {
        self.textView.text = ""
        self.clearButton.isEnabled = false
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.isEmpty == false,
            text == "\n" {
            if let label = sentimentClassifier?.predictedLabel(for: textView.text) {
                // - 텍스트 분석 결과에 따른 이미지를 설정한다.
                switch label {
                case "positive":
                    sentimentImageView.image = #imageLiteral(resourceName: "positive")
                case "negative":
                    sentimentImageView.image = #imageLiteral(resourceName: "negative")
                default:
                    sentimentImageView.image = #imageLiteral(resourceName: "neutral")
                    
                }
            }
        }
        
        textView.becomeFirstResponder()
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.clearButton.isEnabled = textView.text.isEmpty
    }
}
