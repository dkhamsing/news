//
//  TheNewsTests.swift
//  TheNewsTests
//
//  Created by Daniel on 4/29/20.
//  Copyright © 2020 dk. All rights reserved.
//

import XCTest

@testable import TheNews

class TheNewsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

        UserDefaults.standard.removeObject(forKey: Settings.CategoryKey)
        UserDefaults.standard.removeObject(forKey: Settings.StyleKey)
    }

    func testUserDefaultsPropertyWrapperDefaultSetter() throws {
        // When
        let value = UserDefaultsConfig.savedCategory

        // Then
        XCTAssertTrue(value.rawValue == Settings.CategoryDefault.rawValue)
    }

    func testUserDefaultsPropertyWrapperSetter() throws {
        // When
        let category = NewsCategory.entertainment
        UserDefaultsConfig.savedCategory = category

        // Then
        let value = UserDefaultsConfig.savedCategory
        XCTAssertTrue(value.rawValue == category.rawValue)
    }

    func testDefaultConfiguration() throws {
        // Given
        let settings = Settings()

        // Then
        XCTAssertTrue(settings.category.rawValue == Settings.CategoryDefault.rawValue)
        XCTAssertTrue(settings.style.rawValue == Settings.StyleDefault.rawValue)
    }

    func testViewStyleIsTable() {
        // When
        let style = NewsViewModel.Style.lilnews

        // Then
        XCTAssertFalse(style.isTable)
    }

    func testChangingCategoryConfiguration() throws {
        // Given
        var settings = Settings()

        // When
        let category = NewsCategory.business
        settings.category = category

        // Then
        XCTAssertTrue(settings.category.rawValue == category.rawValue)
    }

    func testChangingStyleConfiguration() throws {
        // Given
        var settings = Settings()

        // When
        let style = NewsViewModel.Style.cnn
        settings.style = style

        // Then
        XCTAssertTrue(settings.style.rawValue == style.rawValue)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
