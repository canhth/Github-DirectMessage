//
//  ImagesCacheTests.swift
//  MessengerTests
//
//  Created by Canh Tran Wizeline on 3/11/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import XCTest
@testable import Messenger

final class ImagesCacheTests: MessengerTests {

    private let imageView = UIImageView()
    
    func testStoringValidImage() {
        let imageLink = "https://avatars0.githubusercontent.com/u/1?v=4"
        
        imageView.loadImage(urlString: imageLink)
        
        let expect = expectation(description: "test_image_caching")
        DispatchQueue.main.asyncAfter(deadline: .now() + limitTimeOut - 1) {
            expect.fulfill()
        }
        
        waitForExpectations(timeout: limitTimeOut) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            } else {
                XCTAssertNotNil(ImageCache.shared.image(forKey: imageLink), "Should store a valid link")
            }
        }
    }
    
    func testStoringInvalidImage() {
        let imageLink = "http://githubusercontent.com/u/1?v=4"
        let imageView = UIImageView()
        
        imageView.loadImage(urlString: imageLink)
        
        XCTAssertNil(ImageCache.shared.image(forKey: imageLink), "Should not store a valid link")
    }
}
