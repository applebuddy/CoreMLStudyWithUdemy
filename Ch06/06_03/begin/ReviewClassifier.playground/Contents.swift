import CreateML
import Cocoa

// 두개의 MLDataTable 인스턴스를 설정합니다.
// 1. 학습 데이터 셋을 갖고 있는 테이블
// 2. 학습 데이터 판별 테스트에 사용할 데이터

guard let traingingDataFileURL = Bundle.main.url(forResource: "amazon-reviews", withExtension: "json"),
    let testingDataFileURL = Bundle.main.url(forResource: "testing-reviews", withExtension: "json") else {
        fatalError("Error: Couldn't load resource files")
}

var str = "Hello, createML"

do {
    let traningDataTable = try MLDataTable(contentsOf:  traingingDataFileURL)
    let testingDataTable = try MLDataTable(contentsOf: testingDataFileURL)
    let stats =
    """
    =========================================
    Entries used for traning \(traningDataTable.size)
    Entries used for testing \(testingDataTable.size)
"""
    print(stats)
} catch {
    print(error.localizedDescription)
}


