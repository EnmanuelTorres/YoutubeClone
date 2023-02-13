//
//  PlayVideoPresenterTests.swift
//  YouTubeCloneUITests
//
//  Created by ENMANUEL TORRES on 1/02/23.
//

import XCTest
@testable import YouTubeClone


@MainActor final class PlayVideoPresenterTests: XCTestCase, PlayVideoViewProtocol {
   var sut : PlayVideoPresenter!
    override func setUpWithError() throws {
       sut = PlayVideoPresenter(delegate: self)
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
       
    }

   

}
