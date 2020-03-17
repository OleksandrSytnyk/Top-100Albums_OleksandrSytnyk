//
//  Top_100Albums_OleksandrSytnykTests.swift
//  Top 100Albums_OleksandrSytnykTests
//
//  Created by Oleksandr Sytnyk on 3/15/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import XCTest
@testable import Top_100Albums_OleksandrSytnyk

class Top_100Albums_OleksandrSytnykTests: XCTestCase {
  
  var session: URLSession?
  
  override func setUp() {
    super.setUp()
    session = URLSession(configuration: .default)
  }
  
  override func tearDown() {
    session = nil
    super.tearDown()
  }
  
  // This method allows you test downloading process for both albums and images. You just need to use the corresponding url string.
  func testDownloadingData() {
    // given
    guard let url =
      URL(string: "https://rss.itunes.apple.com/api/v1/us/music-videos/top-music-videos/all/100/explicit.json") else { return }
    let promise = expectation(description: "Completion handler invoked".localized)
    var statusCode: Int?
    var responseError: Error?
    // when
    let dataTask = session?.dataTask(with: url) { data, response, error in
      statusCode = (response as? HTTPURLResponse)?.statusCode
      responseError = error
      promise.fulfill()
    }
    dataTask?.resume()
    wait(for: [promise], timeout: 5)
    // then
    XCTAssertNil(responseError)
    XCTAssertEqual(statusCode, 200)
  }
}
