//
//  URLImageAssetSizeTests.swift
//  Codemine
//
//  Created by Chris on 25/09/2016.
//  Copyright © 2016 Nodes. All rights reserved.
//

import XCTest
@testable import Codemine

class URLImageAssetSizeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
	
	
	func testURLWithSize() {
		guard let url = URL(string: "https://example.com/image.png") else { XCTAssertTrue(false, "Failed to create NSURL"); return }
		let size = CGSize(width: 512, height: 256)
		let heightParameterName = "height"
		let widthParameterName = "width"
		
		let url2 = url.appendingAssetSize(size, mode: .default, heightParameterName: heightParameterName, widthParameterName: widthParameterName)
		XCTAssertEqual(url2?.absoluteString, url.absoluteString + "?\(widthParameterName)=\(Int(size.width * UIScreen.main.scale ))&\(heightParameterName)=\(Int(size.height *  UIScreen.main.scale))")
		
		let url3 = url.appendingAssetSize(size)
		XCTAssertEqual(url3?.absoluteString, url.absoluteString + "?w=\(Int(size.width * UIScreen.main.scale ))&h=\(Int(size.height *  UIScreen.main.scale))")
		
		let url4 = url.appendingAssetSize(size, mode: .crop)
		XCTAssertEqual(url4?.absoluteString, url.absoluteString + "?w=\(Int(size.width * UIScreen.main.scale ))&h=\(Int(size.height *  UIScreen.main.scale))&mode=crop")
		
	}
	
	func testBadUrl() {
		let url = URL(string: "http://example.com:-80/")!
		
        print(URLComponents(url: url, resolvingAgainstBaseURL: false) ?? URLComponents())
		
		let newUrl = url.appendingAssetSize(CGSize(width: 10, height: 10))
		XCTAssertNil(newUrl?.absoluteString, "Bad URL did not return nil")
	}
	

    
}
