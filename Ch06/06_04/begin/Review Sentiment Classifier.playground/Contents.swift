//: **Machine Learning with Core ML 2 and Swift** - Source Code
//:
//: Get the course **[on Udemy using this discounted coupon](https://www.udemy.com/machine-learning-with-core-ml2-and-swift/?couponCode=GITHUB)**
//:
//: The book version is available **[on Amazon](https://www.amazon.com/dp/B07F2NYDTH)**
//:
//: _ _ _
//: ## Review sentiment classifier
//: This playground trains a review sentiment analyzer using JSON data (see Resources -> amazon-reviews.json)
//:
//: - Callout(Interested in Swift programming?):
//: Check out my **[Youtube channel](https://www.youtube.com/c/swiftprogrammingtutorials)**
//: my courses on **[Udemy](https://www.udemy.com/user/karolynyisztor/)**, **[Lynda](https://www.lynda.com/Karoly-Nyisztor/9655357-1.html)** and **[Pluralsight](https://www.pluralsight.com/profile/author/karoly-nyisztor)**.
//: Website **[www.leakka.com](http://www.leakka.com)**
//: ---
import Foundation
import CreateML

guard let trainingDataFileURL = Bundle.main.url(forResource: "amazon-reviews", withExtension: "json"),
let testingDataFileURL = Bundle.main.url(forResource: "testing-reviews", withExtension: "json") else {
    fatalError("Error! Could not load resource files.")
}

do {
    let trainingDataTable = try MLDataTable(contentsOf: trainingDataFileURL)
    let testingDataTable = try MLDataTable(contentsOf: testingDataFileURL)
    
    let stats = """
    ==========================================
    Entries used for training: \(trainingDataTable.size)
    Entries used for testing: \(testingDataTable.size)
    
    """
    print(stats)
    
    /// 의견 판별자 인스턴스 생성
    let sentimentClassifier = try MLTextClassifier(trainingData: trainingDataTable, textColumn: "text", labelColumn: "label")
    let evaluationMetrics = sentimentClassifier.evaluation(on: testingDataTable, textColumn: "text", labelColumn: "label")
    let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100
    
    let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100
    let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100
    
    // Training accuracy, Validation accuracy가 높을 수록, 주어진 입력값에 대해 도출되는 판별결과 신뢰도가 증가한다.
    let message = """
    ==========================================
    Training accuracy: \(trainingAccuracy)
    Validation accuracy: \(validationAccuracy)
    Evaluation accuracy: \(evaluationAccuracy)
    
    """
    print(message)
    
    // Saving the CoreML Model
    // - 자신(applebuddy)의 바탕화면에 해당 mlmodel파일(ReviewClassifier.mlmodel)이 저장된다.
    let modelFileURL = URL(fileURLWithPath: "/Users/applebuddy/Desktop/ReviewClassifier.mlmodel")
    let metaData = MLModelMetadata(author: "MungGu", shortDescription: "A Model trained to classify product review sentiment", version: "1.0")
    try sentimentClassifier.write(to: modelFileURL, metadata: metaData)
} catch {
    print(error.localizedDescription)
}
