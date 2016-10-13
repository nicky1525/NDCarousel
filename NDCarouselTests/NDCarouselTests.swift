//
//  NDCarouselTests.swift
//  NDCarouselTests
//
//  Created by Nicole De La Feld on 15/03/2016.
//  Copyright © 2016 nicky1525. All rights reserved.
//

import XCTest
@testable import NDCarousel

class NDCarouselTests: XCTestCase {
    let names = ["photo1", "photo2","photo3", "photo4", "photo5"]
    var images = [UIImage]()

    var carousel:NDCarousel!
    var carousel1:NDCarousel!
    
    override func setUp() {
        super.setUp()
        
        for photo in names {
            let image = UIImage(named: photo)
            images.append(image!)
        }
        
        carousel = NDCarousel().initWithImages(images: images, animationInterval: 7.0, displaySlideIndicator: true)
        carousel1 = NDCarousel().initWithImages(images: [], animationInterval: 2.0, displaySlideIndicator: false)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSlides() {
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDisplayIndicatorIsVisible() {
        
    }
    
    func testSliderIndicatorSelectedColor() {
        
    }
    
    func testSliderIndicatorTintColor() {
        
    }
    
    func testSliderIndicatorNumberOfPages() {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
