//
//  PlayVideoPresenterTests.swift
//  YouTubeCloneTests
//
//  Created by ENMANUEL TORRES on 2/02/23.
//

import XCTest
@testable import YouTubeClone

@MainActor class PlayVideoPresenterTests: XCTestCase {
    
    var sut : PlayVideoPresenter!
    var sutDelegate : PlayVideoViewMock!
    var providerMock : PlayVideoProviderMock!
    var videoId = "v1mWkw7Lito"
    var timeOut : TimeInterval = 2.0

    @MainActor override func setUpWithError() throws {
        MockManager.shared.runAppwithMock = true
        sutDelegate = PlayVideoViewMock()
        providerMock = PlayVideoProviderMock()
        sut = PlayVideoPresenter(delegate: sutDelegate, provider: providerMock)
    }

    @MainActor override func tearDownWithError() throws {
     
     sutDelegate = nil
     providerMock = nil
     sut = nil
    }
    
    func test_GetVideos() {
        sutDelegate.expgetRelatedVideosFinishedWasCalled = expectation(description: "loading Video")
        sutDelegate.expgLoading = expectation(description: "show?hide loading")
        sutDelegate.expgLoading?.expectedFulfillmentCount = 2
        Task {
            await sut.getVideos(videoId)
        }
        
        waitForExpectations(timeout: timeOut)
        
        
        //Assertions
        guard let videos = sut.relatedVideoList.first as? [VideoModel.Item] else {
            XCTFail("fallo porque no existe el objeto deseo en la primera posicion")
            return
        }
        XCTAssertTrue(videos.first?.id == videoId, "el id recibido no es igual al esperado")
        
        XCTAssertTrue(sut.relatedVideoList.count == 2)
        XCTAssertTrue(sut.channelModel?.id == Constants.channelId, "el id esperado no coincide")
        
        XCTAssertTrue(sutDelegate.loadingViewWasCalled)
        XCTAssertTrue(sutDelegate.loadingHide, "el loading deveria ocultarse")
        XCTAssertTrue(sutDelegate.loadingShow, "el loading deveria mostrarse")
    }

    func test_GetVideos_ShoudFail() {
        MockManager.shared.runAppwithMock = false
        sutDelegate = PlayVideoViewMock()
        providerMock = PlayVideoProviderMock()
        providerMock.throwError = true
        sutDelegate.expShowError = expectation(description: "loading")
        
        sut = PlayVideoPresenter(delegate: sutDelegate, provider: providerMock)
        
        Task{
            await sut.getVideos(videoId)
        }
        waitForExpectations(timeout: timeOut)
        
        XCTAssertFalse(sutDelegate.getRelatedVideosFinishedWasCalled)
        XCTAssertTrue(sutDelegate.showErrorWasCalled)
    }
    func test_GetChannelAndReelatedVideos_ShouldFail(){
        MockManager.shared.runAppwithMock = false
        sutDelegate = PlayVideoViewMock()
        providerMock = PlayVideoProviderMock()
        providerMock.throwError = true
        sutDelegate.expShowError = expectation(description: "loading")
        
        sut = PlayVideoPresenter(delegate: sutDelegate, provider: providerMock)
        
        Task{
            await sut.getChannelAndRelatedVideos(videoId, Constants.channelId)
        }
        waitForExpectations(timeout: timeOut)
        
        XCTAssertTrue(sutDelegate.showErrorWasCalled)
    }
    
    func test_GetSumNumbers() throws {
        var expectedNumber = 20
        let result = sut.getSumNumbers(a: 10, b: 10)
        XCTAssert(result == expectedNumber, "el resultado esperado es \(expectedNumber), pero recibio \(result)")
    }

   

}

class PlayVideoViewMock : PlayVideoViewProtocol {
    var loadingViewWasCalled: Bool = false
    var showErrorWasCalled: Bool = false
    var getRelatedVideosFinishedWasCalled: Bool = false
    var expgetRelatedVideosFinishedWasCalled : XCTestExpectation?
    var expgLoading : XCTestExpectation?
    var expShowError : XCTestExpectation?
    var loadingShow : Bool = false
    var loadingHide : Bool = false
    
    func loadingView(_ state: YouTubeClone.LoadingViewState) {
        if state == .show {
            loadingShow = true
        }else if state == .hide {
            loadingHide = true
        }
        loadingViewWasCalled = true
        expgLoading?.fulfill()
    }
    
    func showError(_ error: String, callback: (() -> Void)?) {
        showErrorWasCalled = true
        expShowError?.fulfill()
        
    }
    
    func getRelatedVideosFinished() {
        getRelatedVideosFinishedWasCalled = true
        expgetRelatedVideosFinishedWasCalled?.fulfill()
    }
}
